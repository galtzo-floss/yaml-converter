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

          document = HexaPDF::Document.new
          page = document.pages.add(page_size(options[:pdf_page_size] || "LETTER"))
          margin = normalize_margin(options[:pdf_margin] || [36, 36, 36, 36])
          content = ContentBox.new(page: page, margin: margin)
          canvas = page.canvas

          draw_lines(canvas, title_lines, content: content, size: options[:pdf_title_font_size] || 14, font: "Helvetica", style: :bold)
          content.move_down(10) if title_lines.any?

          if options[:pdf_two_column_notes] && notes.any?
            draw_two_column_layout(canvas, yaml_section: yaml_section, notes: notes, content: content, options: options)
          else
            draw_lines(canvas, yaml_section, content: content, size: options[:pdf_yaml_font_size] || 9, font: "Courier")
            content.move_down(10)
            draw_lines(canvas, notes.map { |note| "NOTE: #{note}" }, content: content, size: options[:pdf_body_font_size] || 11, font: "Helvetica", style: :italic)
          end

          draw_page_number(canvas, page: page)
          document.write(out_path, optimize: true)
          true
        rescue => e
          warn("hexapdf pdf failed: #{e.class}: #{e.message}")
          false
        end

        ContentBox = Struct.new(:page, :margin, :left, :right, :top, :bottom, :cursor, keyword_init: true) do
          def initialize(page:, margin:)
            width = page.box.width
            height = page.box.height
            super(
              page: page,
              margin: margin,
              left: margin[3],
              right: width - margin[1],
              top: height - margin[0],
              bottom: margin[2],
              cursor: height - margin[0]
            )
          end

          def width
            right - left
          end

          def move_down(amount)
            self.cursor -= amount
          end
        end
        private_constant :ContentBox

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

        def draw_two_column_layout(canvas, yaml_section:, notes:, content:, options: {})
          gap = 16
          column_width = (content.width - gap) / 2.0
          left = content.left
          right = content.left + column_width + gap
          cursor = content.cursor

          yaml_bottom = draw_lines(canvas, yaml_section, content: content, left: left, cursor: cursor, width: column_width, size: options[:pdf_yaml_font_size] || 9, font: "Courier")
          notes_bottom = draw_lines(canvas, notes.map { |note| "NOTE: #{note}" }, content: content, left: right, cursor: cursor, width: column_width, size: options[:pdf_body_font_size] || 11, font: "Helvetica", style: :italic)
          content.cursor = [yaml_bottom, notes_bottom].min
        end

        def draw_lines(canvas, lines, content:, left: content.left, cursor: content.cursor, width: content.width, size: 11, font: "Helvetica", style: nil)
          variant = font_variant(style)
          if variant
            canvas.font(font, variant: variant, size: size)
          else
            canvas.font(font, size: size)
          end
          y = cursor
          Array(lines).each do |line|
            wrapped_lines(line.to_s, width: width, size: size, font: font).each do |wrapped|
              break if y <= content.bottom

              canvas.text(wrapped, at: [left, y])
              y -= line_height(size)
            end
          end
          content.cursor = y if left == content.left && width == content.width
          y
        end

        def wrapped_lines(line, width:, size:, font:)
          max_chars = [(width / average_char_width(size, font)).floor, 1].max
          return [line] if line.length <= max_chars

          line.scan(/.{1,#{max_chars}}/)
        end

        def average_char_width(size, font)
          (font == "Courier") ? size * 0.6 : size * 0.5
        end

        def font_variant(style)
          return :bold if style == :bold
          return :italic if style == :italic

          nil
        end

        def line_height(size)
          size * 1.25
        end

        def draw_page_number(canvas, page:)
          canvas.font("Helvetica", size: 9)
          canvas.text("Page 1 of 1", at: [page.box.width - 136, 36])
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
