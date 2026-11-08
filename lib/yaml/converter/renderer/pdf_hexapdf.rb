# frozen_string_literal: true

module Yaml
  module Converter
    module Renderer
      # Native PDF rendering using HexaPDF.
      # Basic layout: title lines, YAML block in monospace, notes as italic paragraphs.
      #
      # For PDF rendering via pandoc, see {Yaml::Converter::Renderer::PandocShell}.
      module PdfHexapdf
        module_function

        # Render a PDF document from the given markdown string.
        #
        # @param markdown [String] Markdown that includes fenced YAML and blockquote notes
        # @param out_path [String] Destination PDF path
        # @param options [Hash] PDF options (see Config defaults: page size, margins, font sizes, two-column notes)
        # @option options [String] :pdf_page_size ("LETTER")
        # @option options [Array<Integer>] :pdf_margin ([36,36,36,36])
        # @option options [Integer] :pdf_title_font_size (14)
        # @option options [Integer] :pdf_body_font_size (11)
        # @option options [Integer] :pdf_yaml_font_size (9)
        # @option options [Boolean] :pdf_two_column_notes (false)
        # @return [Boolean] true if rendering succeeded
        def render(markdown:, out_path:, options: {})
          require "hexapdf"

          notes = extract_notes(markdown)
          yaml_section = fenced_yaml(markdown)
          title_lines = header_lines(markdown)

          margin = normalize_margin(options[:pdf_margin] || [36, 36, 36, 36])
          # Reserve room for the footer even when the requested bottom margin is smaller.
          margin[2] = [margin[2], 50].max
          size = page_size(options[:pdf_page_size] || "LETTER")
          composer = HexaPDF::Composer.new(page_size: size, margin: margin)
          draw_lines(composer, title_lines, font: "Helvetica", font_size: options[:pdf_title_font_size] || 14, font_variant: :bold)

          if options[:pdf_two_column_notes] && notes.any?
            draw_columns(composer, yaml_section, notes, size: size, margin: margin, options: options)
          else
            draw_lines(composer, yaml_section, font: "Courier", font_size: options[:pdf_yaml_font_size] || 9)
            draw_lines(composer, notes.map { |note| "NOTE: #{note}" }, font: "Helvetica", font_size: options[:pdf_body_font_size] || 11, font_variant: :italic)
          end

          pages = composer.document.pages.to_a
          pages.each_with_index do |page, index|
            page.canvas.font("Helvetica", size: 9).text("Page #{index + 1} of #{pages.length}", at: [page.box.width - 136, 24])
          end
          composer.write(out_path, optimize: true)
          true
        rescue => e
          warn("hexapdf pdf failed: #{e.class}: #{e.message}")
          false
        end

        # Compose each column independently and overlay its pages on the title document.
        def draw_columns(composer, yaml_section, notes, size:, margin:, options: {})
          page = composer.page
          width = page.box.width
          column_width = (width - margin[1] - margin[3] - 16) / 2.0
          start_page = composer.document.pages.count - 1
          first_top = page.box.height - composer.y
          columns = [
            [yaml_section, [margin[0], width - margin[3] - column_width, margin[2], margin[3]],
              {font: "Courier", font_size: options[:pdf_yaml_font_size] || 9}],
            [notes.map { |note| "NOTE: #{note}" }, [margin[0], margin[1], margin[2], margin[3] + column_width + 16],
              {font: "Helvetica", font_size: options[:pdf_body_font_size] || 11, font_variant: :italic}]
          ]
          columns.each do |lines, column_margin, style|
            column = HexaPDF::Composer.new(skip_page_creation: true)
            column.page_style(:continuation, page_size: size) do |canvas, page_style|
              page_style.frame = page_style.create_frame(canvas.context, column_margin)
            end
            column.page_style(:first, page_size: size, next_style: :continuation) do |canvas, page_style|
              page_style.frame = page_style.create_frame(canvas.context, [first_top, *column_margin[1..]])
            end
            column.new_page(:first)
            draw_lines(column, lines, **style)
            column.document.dispatch_message(:complete_objects)
            column.document.validate
            column.document.pages.each_with_index do |column_page, index|
              composer.new_page while composer.document.pages.count <= start_page + index
              target = composer.document.pages[start_page + index]
              form = column.document.add(column_page.to_form_xobject)
              target.canvas.xobject(composer.document.import(form), at: [0, 0])
            end
          end
        end

        def draw_lines(composer, lines, **style)
          variant = style.delete(:font_variant)
          style[:font] = composer.document.fonts.add(style[:font], variant: variant) if variant
          lines.each do |line|
            indent = (style[:font] == "Courier") ? line[/\A */].length * style[:font_size] * 0.6 : 0
            composer.text(line.empty? ? " " : line, text_indent: indent, **style)
          end
        end

        def page_size(name)
          case name.to_s.upcase
          when "A4"
            :A4
          when "LEGAL"
            [0, 0, 612, 1008]
          else
            :Letter
          end
        end

        def normalize_margin(margin)
          values = Array(margin).map(&:to_i)
          return [36, 36, 36, 36] unless values.size == 4

          values
        end

        # Extract leading `# Title lines`.
        # @param markdown [String]
        # @return [Array<String>]
        def header_lines(markdown)
          markdown.lines.take_while { |l| l.start_with?("# ") }.map { |l| l.sub(/^# /, "").strip }
        end

        # Return the lines inside the first fenced ```yaml block.
        # @param markdown [String]
        # @return [Array<String>]
        def fenced_yaml(markdown)
          inside = false
          lines = []
          markdown.each_line do |l|
            if l.start_with?("```yaml")
              inside = true
              next
            elsif inside && l.strip == "```"
              inside = false
              break
            elsif inside
              lines << l.rstrip
            end
          end
          lines
        end

        # Extract note strings from Markdown blockquote lines.
        # @param markdown [String]
        # @return [Array<String>]
        def extract_notes(markdown)
          markdown.lines.grep(/^> NOTE:/).map { |l| l.sub(/^> NOTE:\s*/, "").strip }
        end
      end
    end
  end
end
