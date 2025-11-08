# frozen_string_literal: true

require "date"

module Yaml
  module Converter
    class MarkdownEmitter
      START_YAML = "```yaml"
      END_YAML = "```"
      VALIDATED_STR = "YAML validation:"
      NOTE_STR = "note:"

      def initialize(options)
        @max_len = options.fetch(:max_line_length)
        @truncate = options.fetch(:truncate)
        @margin_notes = options.fetch(:margin_notes)
        @validate = options.fetch(:validate)
        @validation_status = :ok
        @is_latex = false # reserved for future; PDF layout handled elsewhere
      end

      def set_validation_status(status)
        @validation_status = status
      end

      # Convert a list of input lines into Markdown following python yaml2doc behavior.
      # lines: Array<String>
      def emit(lines)
        out = []
        state = :text
        latex_setup = false

        lines.each do |raw|
          line = raw.rstrip
          if line.empty?
            out << ""
            next
          end

          if line.start_with?("# ") || line == "#"
            out << END_YAML if state != :text
            content = (line == "#") ? "" : line[2..]
            if content.start_with?(VALIDATED_STR)
              date = Date.today.strftime("%d/%m/%Y")
              status_str = ((@validation_status == :ok) ? "OK" : "Fail")
              out << "#{VALIDATED_STR}*#{status_str}* on #{date}"
            else
              out << content
            end
            state = :text
            next
          end

          # skip document separator
          if line == "---"
            next
          end

          # Leading dash at column 0 becomes a markdown heading line per python behavior
          if line.start_with?("-")
            out << "# #{line[1..-1].strip.gsub(/\s+$/, "")}"
          end

          # transition to YAML state if needed
          if state != :yaml
            out << START_YAML
            state = :yaml
          end

          # Handle inline #note:
          start_comment = line.index("#" + NOTE_STR)
          if start_comment && @margin_notes != :ignore
            # emit note outside YAML block
            out << END_YAML
            unless latex_setup
              # In python LaTeX, this sets margin; for markdown we emulate with blockquote note
              latex_setup = true
            end
            note_text = line[(start_comment + 1 + NOTE_STR.length)..].to_s.strip
            out << "> NOTE: #{note_text}"
            out << START_YAML
            line = line[0...start_comment].rstrip
          end

          if @truncate && line.length > @max_len
            line = line[0...(@max_len - 2)] + ".."
          end

          out << line
        end

        out << END_YAML if state == :yaml
        out << "---- \n\nProduced by [yaml-converter](https://github.com/kettle-rb/yaml-converter)"
        out
      end
    end
  end
end
