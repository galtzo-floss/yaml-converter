# frozen_string_literal: true

require "date"
require_relative "parser"
require_relative "state_machine"

module Yaml
  module Converter
    # High-level emitter orchestrates parsing tokens and applying the state machine,
    # producing a Markdown document with fenced YAML blocks and extracted notes.
    class MarkdownEmitter
      START_YAML = "```yaml"
      END_YAML = "```"
      VALIDATED_STR = "YAML validation:"
      NOTE_STR = "note:"

      # @param options [Hash] Configuration values merged from {Config.resolve}
      def initialize(options)
        @options = options
        @max_len = options.fetch(:max_line_length)
        @truncate = options.fetch(:truncate)
        @margin_notes = options.fetch(:margin_notes)
        @validate = options.fetch(:validate)
        @validation_status = :ok
        @is_latex = false
      end

      # Set the validation status used when injecting the validation status line.
      # @param status [Symbol] :ok or :fail
      # @return [void]
      def set_validation_status(status)
        @validation_status = status
      end

      # Convert input lines to markdown using parser + state machine, then append a footer.
      # @param lines [Array<String>] Raw YAML file lines
      # @return [Array<String>] Final markdown lines
      def emit(lines)
        parser = Parser.new(@options)
        tokens = parser.tokenize(lines)
        sm = StateMachine.new(validation_status: @validation_status, max_line_length: @max_len, truncate: @truncate, margin_notes: @margin_notes, current_date: @options[:current_date])
        body = sm.apply(tokens)
        if @options[:emit_footer]
          body << "---- \n\nProduced by [yaml-converter](https://github.com/kettle-rb/yaml-converter)"
        end
        body
      end
    end
  end
end
