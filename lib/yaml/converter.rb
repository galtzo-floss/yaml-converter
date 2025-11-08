# frozen_string_literal: true

require_relative "converter/version"
require_relative "converter/config"
require_relative "converter/validation"
require_relative "converter/markdown_emitter"

module Yaml
  module Converter
    class Error < StandardError; end
    class InvalidArgumentsError < Error; end
    class RendererUnavailableError < Error; end

    module_function

    # Public: Convert a YAML string into Markdown, with validation status injection.
    # @param yaml_string [String]
    # @param options [Hash]
    # @return [String] markdown content
    def to_markdown(yaml_string, options: {})
      opts = Config.resolve(options)
      emitter = MarkdownEmitter.new(opts)
      if opts[:validate]
        validation = Validation.validate_string(yaml_string)
        emitter.set_validation_status(validation[:status])
      end
      emitter.emit(yaml_string.lines).join("\n")
    end

    # Public: Validate YAML string
    # @return [Hash] { status: :ok|:fail, error: Exception|nil }
    def validate(yaml_string)
      Validation.validate_string(yaml_string)
    end

    # Public: Convert from input file to a given output path based on extension.
    # Writes files as needed and returns a result hash.
    # @param input_path [String]
    # @param output_path [String]
    # @param options [Hash]
    # @return [Hash] { status:, output_path:, validation: }
    def convert(input_path:, output_path:, options: {})
      raise InvalidArgumentsError, "input file not found: #{input_path}" unless File.exist?(input_path)

      ext = File.extname(output_path)
      if ext == ".yaml"
        raise InvalidArgumentsError, "Output must not be .yaml"
      end

      opts = Config.resolve(options)
      yaml_string = File.read(input_path)

      markdown = to_markdown(yaml_string, options: opts)

      case ext
      when ".md", ""
        File.write(output_path, markdown)
        { status: :ok, output_path: output_path, validation: (opts[:validate] ? Validation.validate_string(yaml_string) : { status: :ok, error: nil }) }
      when ".html"
        require "kramdown"
        body_html = Kramdown::Document.new(markdown).to_html
        note_style = ""
        if markdown.include?("> NOTE:")
          note_style = "<style>.yaml-note{font-style:italic;color:#555;margin-left:1em;}</style>\n"
          body_html = body_html.gsub(/<blockquote>/, '<blockquote class="yaml-note">')
        end
        html = <<~HTML
          <!DOCTYPE html>
          <html>
          <head>
          <meta charset="utf-8">
          #{note_style}</head>
          <body>
          #{body_html}
          </body>
          </html>
        HTML
        File.write(output_path, html)
        { status: :ok, output_path: output_path, validation: (opts[:validate] ? Validation.validate_string(yaml_string) : { status: :ok, error: nil }) }
      else
        # For now, write intermediate .md next to output and rely on pandoc if configured later.
        tmp_md = output_path + ".md"
        File.write(tmp_md, markdown)
        # Phase 1: we do not execute pandoc yet; return a clear error to guide usage.
        raise RendererUnavailableError, "Renderer for #{ext} not implemented in Phase 1. Use .md or .html for now."
      end
    end
  end
end

# Extend the Version with VersionGem::Basic to provide semantic version helpers.
Yaml::Converter::Version.class_eval do
  extend VersionGem::Basic
end
