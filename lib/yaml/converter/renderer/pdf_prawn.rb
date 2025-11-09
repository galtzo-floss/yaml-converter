# frozen_string_literal: true

require "prawn"

module Yaml
  module Converter
    module Renderer
      # Native PDF rendering using prawn.
      # Basic layout: title lines, YAML block in monospace, notes as italic paragraphs.
      module PdfPrawn
        module_function

        def render(markdown:, out_path:, options: {})
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
                pdf.font("Courier") do
                  yaml_section.each { |l| pdf.text(l) }
                end
              end
              pdf.bounding_box([pdf.bounds.left + col_width + col_gap, pdf.cursor], width: col_width, height: pdf.cursor) do
                pdf.font_size(body_fs)
                notes.each { |n| pdf.text("NOTE: #{n}", style: :italic) }
              end
            else
              pdf.font_size(yaml_fs)
              pdf.font("Courier") do
                yaml_section.each { |l| pdf.text(l) }
              end
              pdf.move_down(10)

              unless notes.empty?
                pdf.font_size(body_fs)
                notes.each do |n|
                  pdf.text("NOTE: #{n}", style: :italic)
                end
              end
            end

            pdf.number_pages("Page <page> of <total>", at: [pdf.bounds.right - 100, 0])
          end
          true
        rescue StandardError => e
          warn("prawn pdf failed: #{e.class}: #{e.message}")
          false
        end

        def header_lines(markdown)
          markdown.lines.take_while { |l| l.start_with?("# ") }.map { |l| l.sub(/^# /, "").strip }
        end

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

        def extract_notes(markdown)
          markdown.lines.grep(/^> NOTE:/).map { |l| l.sub(/^> NOTE:\s*/, "").strip }
        end
      end
    end
  end
end
