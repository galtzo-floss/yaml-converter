# frozen_string_literal: true

module Yaml
  module Converter
    # Tokenizes input YAML lines (with inline annotations) into structured tokens
    # consumable by the {Yaml::Converter::StateMachine}.
    #
    # Input assumptions:
    # - Comment titles: lines starting with `# ` become title tokens.
    # - Validation marker: a comment line starting with `# YAML validation:` is recognized.
    # - Separator lines (`---`) are recognized and currently ignored by the state machine.
    # - Inline notes: fragments after `#note:` are captured as out-of-band NOTE tokens.
    # - Other non-empty lines are treated as YAML content.
    class Parser
      # Lightweight token structure used by the parser/state machine pipeline.
      #
      # @!attribute [rw] type
      #   @return [Symbol] One of :blank, :title, :validation, :separator, :dash_heading, :yaml_line, :note
      # @!attribute [rw] text
      #   @return [String] Payload string for this token
      # @!attribute [rw] meta
      #   @return [Hash,nil] Optional metadata bag (currently unused)
      Token = Struct.new(:type, :text, :meta, keyword_init: true)

      # Comment line prefix indicating a validation status line will be injected
      VALIDATION_PREFIX = "# YAML validation:"
      # Inline note marker captured from right side of a line
      NOTE_MARK = "#note:"

      # @param options [Hash] Reserved for future parsing options
      def initialize(options = {})
        @options = options
      end

      # Convert raw lines into token objects.
      #
      # @param lines [Array<String>] Input lines (including newlines)
      # @return [Array<Token>] Sequence of tokens representing the document structure
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
