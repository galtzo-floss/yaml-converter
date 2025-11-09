# frozen_string_literal: true

require 'date'

module Yaml
  module Converter
    # Simple state machine to transform tokens into markdown lines.
    class StateMachine
      START_YAML = "```yaml"
      END_YAML = "```"

      def initialize(options = {})
        @options = options
        @validate_status = options.fetch(:validation_status, :ok)
        @max_len = options.fetch(:max_line_length, 70)
        @truncate = options.fetch(:truncate, true)
        @margin_notes = options.fetch(:margin_notes, :auto)
      end

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
            state = :text
          when :validation
            close_yaml(out, state)
            date = Date.today.strftime("%d/%m/%Y")
            status_str = (@validate_status == :ok ? "OK" : "Fail")
            out << "YAML validation:*#{status_str}* on #{date}"
            state = :text
          when :separator
            # ignore
          when :dash_heading
            close_yaml(out, state)
            out << "# #{t.text}".strip
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
              out << "> NOTE: #{t.text}"
              state = was_yaml ? open_yaml(out, :text) : :text
            end
          end
        end
        close_yaml(out, state)
        out
      end

      private

      def open_yaml(out, state)
        if state != :yaml
          out << START_YAML
          :yaml
        else
          state
        end
      end

      def close_yaml(out, state)
        if state == :yaml
          out << END_YAML
        end
      end
    end
  end
end
