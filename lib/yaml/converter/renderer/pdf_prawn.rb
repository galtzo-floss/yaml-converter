# frozen_string_literal: true

require 'prawn'

module Yaml
  module Converter
    module Renderer
      # Native PDF rendering using prawn.
      # Basic layout: title lines, YAML block in monospace, notes as italic paragraphs.
      module PdfPrawn
        module_function

        DEFAULT_FONT_SIZE = 10
        MONO_FONT_SIZE = 9

        def render(markdown:, out_path:, options: {})
          notes = extract_notes(markdown)
          yaml_section = fenced_yaml(markdown)
          title_lines = header_lines(markdown)

          Prawn::Document.generate(out_path) do |pdf|
            pdf.font_size(DEFAULT_FONT_SIZE)
            title_lines.each { |l| pdf.text(l, style: :bold) }
            pdf.move_down(10)

            pdf.font_size(MONO_FONT_SIZE)
            pdf.font('Courier') do
              yaml_section.each { |l| pdf.text(l) }
            end
            pdf.move_down(10)

            unless notes.empty?
              pdf.font_size(DEFAULT_FONT_SIZE)
              notes.each do |n|
                pdf.text("NOTE: #{n}", style: :italic)
              end
            end
            pdf.number_pages "Page <page> of <total>", at: [pdf.bounds.right - 100, 0]
          end
          true
        rescue StandardError => e
          warn "prawn pdf failed: #{e.class}: #{e.message}"
          false
        end

        def header_lines(markdown)
          markdown.lines.take_while { |l| l.start_with?('# ') }.map { |l| l.sub(/^# /, '').strip }
        end

        def fenced_yaml(markdown)
          inside = false
          lines = []
          markdown.each_line do |l|
            if l.start_with?('```yaml')
              inside = true
              next
            elsif inside && l.strip == '```'
              inside = false
              break
            elsif inside
              lines << l.rstrip
            end
          end
          lines
        end

        def extract_notes(markdown)
          markdown.lines.grep(/^> NOTE:/).map { |l| l.sub(/^> NOTE:\s*/, '').strip }
        end
      end
    end
  end
end

