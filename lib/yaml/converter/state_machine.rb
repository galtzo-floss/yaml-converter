# frozen_string_literal: true

require "date"

module Yaml
  module Converter
    # Simple state machine to transform {Parser::Token} sequences into
    # Markdown lines. Produces:
    # - Title lines as plain paragraphs
    # - A validation status line (formatted with date)
    # - Fenced YAML blocks for YAML content
    # - Blockquoted notes (outside fences)
    class StateMachine
      START_YAML = "```yaml"
      END_YAML = "```"

      # @param options [Hash]
      # @option options [Symbol] :validation_status (:ok) Injected validation result (:ok or :fail)
      # @option options [Integer] :max_line_length (70)
      # @option options [Boolean] :truncate (true)
      # @option options [Symbol] :margin_notes (:auto)
      # @option options [Date] :current_date (Date.today)
      def initialize(options = {})
        @options = options
        @validate_status = options.fetch(:validation_status, :ok)
        @max_len = options.fetch(:max_line_length, 70)
        @truncate = options.fetch(:truncate, true)
        @margin_notes = options.fetch(:margin_notes, :auto)
        @current_date = options[:current_date] || Date.today
      end

      # Apply stateful transformations to tokens and emit Markdown lines.
      #
      # @param tokens [Array<Parser::Token>]
      # @return [Array<String>] Output lines (without trailing newlines)
      def apply(tokens)
        out = []
        state = :text
        tokens.each do |t|
          case t.type
          when :blank
            out << ""
          when :title
            close_yaml(out, state)
            out << t.text
            out << ""
            state = :text
          when :validation
            close_yaml(out, state)
            date = @current_date.strftime("%d/%m/%Y")
            status_str = ((@validate_status == :ok) ? "OK" : "Fail")
            out << "YAML validation:*#{status_str}* on #{date}"
            out << ""
            state = :text
          when :separator
            # ignore
          when :dash_heading
            close_yaml(out, state)
            out << "# #{t.text}".strip
            out << ""
            state = :text
          when :yaml_line
            state = open_yaml(out, state)
            line = t.text
            if @truncate && line.length > @max_len
              line = line[0...(@max_len - 2)] + ".."
            end
            out << line
          when :note
            if @margin_notes != :ignore
              was_yaml = (state == :yaml)
              close_yaml(out, state)
              out << "" if out.last && out.last != ""
              out << "> NOTE: #{t.text}"
              out << ""
              state = was_yaml ? open_yaml(out, :text) : :text
            end
          else
            # unknown token type: ignore gracefully
          end
        end
        close_yaml(out, state)
        out
      end

      private

      # Open a fenced YAML block if not already inside one.
      # @param out [Array<String>]
      # @param state [Symbol]
      # @return [Symbol] new state
      def open_yaml(out, state)
        if state != :yaml
          out << "" if out.last && out.last != ""
          out << START_YAML
          :yaml
        else
          state
        end
      end

      # Close a fenced YAML block if currently inside one.
      # @param out [Array<String>]
      # @param state [Symbol]
      # @return [void]
      def close_yaml(out, state)
        if state == :yaml
          out << END_YAML
          # removed trailing blank line to keep legacy expected output pattern
        end
      end
    end
  end
end
