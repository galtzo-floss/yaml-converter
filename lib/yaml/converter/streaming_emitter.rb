# frozen_string_literal: true

require "date"
require_relative "parser"

module Yaml
  module Converter
    # StreamingEmitter converts YAML to Markdown incrementally.
    # It mirrors MarkdownEmitter + StateMachine behavior while writing to an IO target.
    # Intended for very large inputs to avoid building all output in memory.
    class StreamingEmitter
      START_YAML = "```yaml"
      END_YAML = "```"

      # @param options [Hash] same normalized options as Config.resolve
      # @param io [#<<] destination IO (e.g., File) that receives lines with "\n"
      def initialize(options, io)
        @options = options
        @io = io
        @validation_status = :ok
        @state = :text
        @_last_line_blank = nil
      end

      # Set the validation status used when injecting the validation status line.
      # @param status [Symbol] :ok or :fail
      # @return [void]
      def set_validation_status(status)
        @validation_status = status
      end

      # Stream-convert an input file path to the configured IO.
      # @param input_path [String]
      # @return [void]
      def emit_file(input_path)
        File.open(input_path, "r") do |f|
          f.each_line do |raw|
            emit_line(raw)
          end
        end
        close_yaml
        emit_footer if @options[:emit_footer]
      end

      private

      def max_len
        @options.fetch(:max_line_length)
      end

      def truncate?
        @options.fetch(:truncate)
      end

      def margin_notes
        @options.fetch(:margin_notes)
      end

      def current_date
        @options[:current_date] || Date.today
      end

      def emit_line(raw)
        # Reuse Parser for correctness on a per-line basis
        parser = (@_parser ||= Parser.new(@options))
        tokens = parser.tokenize([raw])
        tokens.each { |t| handle_token(t) }
      end

      def handle_token(t)
        case t.type
        when :blank
          write_line("")
        when :title
          close_yaml
          write_line(t.text)
          write_line("")
        when :validation
          close_yaml
          date = current_date.strftime("%d/%m/%Y")
          status_str = ((@validation_status == :ok) ? "OK" : "Fail")
          write_line("YAML validation:*#{status_str}* on #{date}")
          write_line("")
        when :separator
          # ignore
        when :dash_heading
          close_yaml
          write_line("# #{t.text}".strip)
          write_line("")
        when :yaml_line
          open_yaml
          line = t.text
          if truncate? && line.length > max_len
            line = line[0...(
              max_len - 2
            )] + ".."
          end
          write_line(line)
        when :note
          return if margin_notes == :ignore
          was_yaml = (@state == :yaml)
          close_yaml
          write_line("") if last_line_not_blank?
          write_line("> NOTE: #{t.text}")
          write_line("")
          open_yaml if was_yaml
        else
          # ignore unknown types
        end
      end

      def open_yaml
        return if @state == :yaml
        write_line("") if last_line_not_blank?
        write_line(START_YAML)
        @state = :yaml
      end

      def close_yaml
        if @state == :yaml
          write_line(END_YAML)
          @state = :text
        end
      end

      def emit_footer
        write_line("---- ")
        write_line("")
        write_line("Produced by [yaml-converter](https://github.com/kettle-rb/yaml-converter)")
      end

      def write_line(s)
        if @wrote_any_line
          @io << "\n"
        end
        @io << s
        @wrote_any_line = true
        @_last_line_blank = (s == "")
      end

      def last_line_not_blank?
        @_last_line_blank == false
      end
    end
  end
end
