# frozen_string_literal: true

module Yaml
  module Converter
    # Tokenizes input lines into structured elements for the state machine.
    class Parser
      Token = Struct.new(:type, :text, :meta, keyword_init: true)

      VALIDATION_PREFIX = "# YAML validation:"
      NOTE_MARK = "#note:"

      def initialize(options = {})
        @options = options
      end

      # @param lines [Array<String>]
      # @return [Array<Token>]
      def tokenize(lines)
        tokens = []
        lines.each do |raw|
          line = raw.rstrip
          if line.empty?
            tokens << Token.new(type: :blank, text: "")
            next
          end

          if line.start_with?("# ") || line == "#"
            if line.start_with?(VALIDATION_PREFIX)
              tokens << Token.new(type: :validation, text: line[2..])
            else
              content = (line == "#") ? "" : line[2..]
              tokens << Token.new(type: :title, text: content)
            end
            next
          end

          if line == "---"
            tokens << Token.new(type: :separator, text: line)
            next
          end

          if line.start_with?("-")
            tokens << Token.new(type: :dash_heading, text: line[1..].strip)
          end

          note_idx = line.index(NOTE_MARK)
          if note_idx
            base = line[0...note_idx].rstrip
            note = line[(note_idx + NOTE_MARK.length)..].to_s.strip
            tokens << Token.new(type: :yaml_line, text: base)
            tokens << Token.new(type: :note, text: note)
          else
            tokens << Token.new(type: :yaml_line, text: line)
          end
        end
        tokens
      end
    end
  end
end

