# frozen_string_literal: true

require "date"
require_relative 'parser'
require_relative 'state_machine'

module Yaml
  module Converter
    class MarkdownEmitter
      START_YAML = "```yaml"
      END_YAML = "```"
      VALIDATED_STR = "YAML validation:"
      NOTE_STR = "note:"

      def initialize(options)
        @options = options
        @max_len = options.fetch(:max_line_length)
        @truncate = options.fetch(:truncate)
        @margin_notes = options.fetch(:margin_notes)
        @validate = options.fetch(:validate)
        @validation_status = :ok
        @is_latex = false
      end

      def set_validation_status(status)
        @validation_status = status
      end

      # Convert input lines to markdown using parser + state machine, then append footer.
      def emit(lines)
        parser = Parser.new(@options)
        tokens = parser.tokenize(lines)
        # upgrade validation token text with status via state machine options
        sm = StateMachine.new(validation_status: @validation_status, max_line_length: @max_len, truncate: @truncate, margin_notes: @margin_notes)
        body = sm.apply(tokens)
        body << "---- \n\nProduced by [yaml-converter](https://github.com/kettle-rb/yaml-converter)"
        body
      end
    end
  end
end
