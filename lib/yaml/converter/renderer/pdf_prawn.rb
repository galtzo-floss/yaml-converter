# frozen_string_literal: true

module Yaml
  module Converter
    module Renderer
      # Native PDF rendering using prawn.
      # Basic layout: title lines, YAML block in monospace, notes as italic paragraphs.
      #
      # For PDF rendering via pandoc, see {Yaml::Converter::Renderer::PandocShell}.
      module PdfPrawn
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
          require "prawn"

          notes = extract_notes(markdown)
          yaml_section = fenced_yaml(markdown)
          title_lines = header_lines(markdown)

          page_size = options[:pdf_page_size] || "LETTER"
          margin = options[:pdf_margin] || [36, 36, 36, 36]
          title_fs = options[:pdf_title_font_size] || 14
          body_fs = options[:pdf_body_font_size] || 11
          yaml_fs = options[:pdf_yaml_font_size] || 9
          two_col = !!options[:pdf_two_column_notes]

          Prawn::Document.generate(out_path, page_size: page_size, margin: margin) do |pdf|
            pdf.font_size(title_fs)
            title_lines.each { |l| pdf.text(l, style: :bold) }
            pdf.move_down(10) if title_lines.any?

            if two_col && notes.any?
              # Create two columns: left for YAML, right for notes
              col_gap = 16
              col_width = (pdf.bounds.width - col_gap) / 2.0
              pdf.bounding_box([pdf.bounds.left, pdf.cursor], width: col_width, height: pdf.cursor) do
                pdf.font_size(yaml_fs)
                pdf.font("Courier") { yaml_section.each { |l| pdf.text(l) } }
              end
              pdf.bounding_box([pdf.bounds.left + col_width + col_gap, pdf.cursor], width: col_width, height: pdf.cursor) do
                pdf.font_size(body_fs)
                notes.each { |n| pdf.text("NOTE: #{n}", style: :italic) }
              end
            else
              pdf.font_size(yaml_fs)
              pdf.font("Courier") { yaml_section.each { |l| pdf.text(l) } }
              pdf.move_down(10)
              unless notes.empty?
                pdf.font_size(body_fs)
                notes.each { |n| pdf.text("NOTE: #{n}", style: :italic) }
              end
            end

            pdf.number_pages("Page <page> of <total>", at: [pdf.bounds.right - 100, 0])
          end
          true
        rescue StandardError => e
          warn("prawn pdf failed: #{e.class}: #{e.message}")
          false
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
