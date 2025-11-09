# frozen_string_literal: true

# External dependencies
require "version_gem"

# This library
require_relative "converter/version"
require_relative "converter/config"
require_relative "converter/validation"
require_relative "converter/markdown_emitter"
require_relative "converter/streaming_emitter"

module Yaml
  module Converter
    # Base error class for all yaml-converter specific exceptions.
    class Error < StandardError; end
    # Raised when provided arguments (paths, extensions, etc.) are invalid.
    class InvalidArgumentsError < Error; end
    # Raised when a requested renderer is not available or implemented.
    class RendererUnavailableError < Error; end
    # Raised when pandoc rendering is requested but pandoc cannot be located.
    class PandocNotFoundError < Error; end

    module_function

    # Convert a YAML string into Markdown with optional validation & notes extraction.
    #
    # @param yaml_string [String] Raw YAML content (with optional inline `#note:` annotations or validation marker line)
    # @param options [Hash, Config::DEFAULTS] User overrides for configuration (see {Yaml::Converter::Config::DEFAULTS})
    # @option options [Boolean] :validate (true) Whether to attempt YAML parsing and inject validation status.
    # @option options [Integer] :max_line_length (70) Maximum line length before truncation.
    # @option options [Boolean] :truncate (true) Whether to truncate overly long lines.
    # @option options [Symbol] :margin_notes (:auto) How to handle notes (:auto, :inline, :ignore).
    # @option options [Date] :current_date (Date.today) Deterministic date injection for specs.
    # @return [String] Markdown document including fenced YAML and extracted notes.
    # @example Simple conversion
    #   Yaml::Converter.to_markdown("foo: 1 #note: first")
    def to_markdown(yaml_string, options: {})
      opts = Config.resolve(options)
      emitter = MarkdownEmitter.new(opts)
      if opts[:validate]
        validation = Validation.validate_string(yaml_string)
        status = (validation && validation[:status] == :ok) ? :ok : :fail
        emitter.set_validation_status(status)
      end
      emitter.emit(yaml_string.lines).join("\n")
    end

    # Stream a YAML file to Markdown into an IO target.
    # Automatically injects validation status if enabled.
    # @param input_path [String]
    # @param io [#<<]
    # @param options [Hash]
    # @return [void]
    def to_markdown_streaming(input_path, io, options: {})
      opts = Config.resolve(options)
      emitter = StreamingEmitter.new(opts, io)
      if opts[:validate]
        validation = Validation.validate_file(input_path)
        status = (validation && validation[:status] == :ok) ? :ok : :fail
        emitter.set_validation_status(status)
      end
      emitter.emit_file(input_path)
      nil
    end

    # Validate a YAML string returning a structured status.
    #
    # @param yaml_string [String]
    # @return [Hash{Symbol=>Object}] Hash with :status (:ok|:fail) and :error (Exception or nil)
    # @example
    #   Yaml::Converter.validate("foo: bar") #=> { status: :ok, error: nil }
    def validate(yaml_string)
      Validation.validate_string(yaml_string)
    end

    # Convert a YAML file to a target format determined by the output extension.
    #
    # Supported extensions (Phase 1): .md, .html, .pdf (native), .docx (pandoc).
    # Other formats may be produced via pandoc when :use_pandoc is true.
    #
    # @param input_path [String] Path to existing .yaml source file.
    # @param output_path [String] Destination file (extension decides rendering strategy).
    # @param options [Hash] See {#to_markdown} plus pandoc/pdf specific keys.
    # @option options [Boolean] :use_pandoc (false) Enable pandoc for non-native conversions.
    # @option options [Array<String>] :pandoc_args (["-N", "--toc"]) Extra pandoc CLI args.
    # @option options [String,nil] :pandoc_path (nil) Explicit pandoc binary path (auto-detected if nil).
    # @option options [Boolean] :pdf_two_column_notes (false) Layout notes beside YAML in PDF.
    # @option options [Boolean] :streaming (false) Force streaming mode for markdown conversion.
    # @option options [Integer] :streaming_threshold_bytes (5_000_000) Auto-enable streaming over this size when not forced.
    # @return [Hash] { status: Symbol, output_path: String, validation: Hash }
    # @raise [InvalidArgumentsError] if input is missing or an invalid extension is requested.
    # @raise [PandocNotFoundError] when pandoc rendering requested & missing.
    # @raise [RendererUnavailableError] for unsupported formats.
    # @example HTML conversion
    #   Yaml::Converter.convert(input_path: "blueprint.yaml", output_path: "blueprint.html", options: {})
    def convert(input_path:, output_path:, options: {})
      raise InvalidArgumentsError, "input file not found: #{input_path}" unless File.exist?(input_path)

      ext = File.extname(output_path)
      if ext == ".yaml"
        raise InvalidArgumentsError, "Output must not be .yaml"
      end

      opts = Config.resolve(options)
      yaml_string = nil

      if File.exist?(output_path) && ENV["KETTLE_TEST_SILENT"] != "true"
        warn("Overwriting existing file: #{output_path}")
      end

      auto_stream = !opts[:streaming] && File.size?(input_path) && File.size(input_path) >= opts[:streaming_threshold_bytes]

      if ext == ".md" || ext == ""
        # Direct markdown output path: stream to file for large inputs
        File.open(output_path, "w") do |io|
          if opts[:streaming] || auto_stream
            to_markdown_streaming(input_path, io, options: opts)
          else
            yaml_string = File.read(input_path)
            io.write(to_markdown(yaml_string, options: opts))
          end
        end
        if opts[:validate]
          validation_result = if yaml_string
                               Validation.validate_string(yaml_string)
                             else
                               Validation.validate_file(input_path)
                             end
        else
          validation_result = {status: :ok, error: nil}
        end
        return {status: :ok, output_path: output_path, validation: validation_result}
      end

      # For non-markdown outputs, we still produce an intermediate markdown string.
      yaml_string = File.read(input_path) if yaml_string.nil?
      markdown = to_markdown(yaml_string, options: opts)

      case ext
      when ".html"
        require "kramdown"
        body_html = Kramdown::Document.new(markdown, input: "GFM").to_html
        note_style = ""
        if markdown.include?("> NOTE:")
          note_style = "<style>.yaml-note{font-style:italic;color:#555;margin-left:1em;}</style>\n"
          body_html = body_html.gsub("<blockquote>", '<blockquote class="yaml-note">')
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
        {status: :ok, output_path: output_path, validation: (opts[:validate] ? Validation.validate_string(yaml_string) : {status: :ok, error: nil})}
      when ".pdf"
        opts = Config.resolve(options)
        if opts[:use_pandoc]
          tmp_md = output_path + ".md"
          File.write(tmp_md, markdown)
          require_relative "converter/renderer/pandoc_shell"
          ok = Renderer::PandocShell.render(md_path: tmp_md, out_path: output_path, pandoc_path: opts[:pandoc_path], args: opts[:pandoc_args])
          File.delete(tmp_md) if File.exist?(tmp_md)
          raise PandocNotFoundError, "pandoc not found in PATH" unless ok
          {status: :ok, output_path: output_path, validation: (opts[:validate] ? Validation.validate_string(yaml_string) : {status: :ok, error: nil})}
        else
          require_relative "converter/renderer/pdf_prawn"
          ok = Renderer::PdfPrawn.render(markdown: markdown, out_path: output_path, options: opts)

          raise RendererUnavailableError, "PDF rendering failed" unless ok
          {status: :ok, output_path: output_path, validation: (opts[:validate] ? Validation.validate_string(yaml_string) : {status: :ok, error: nil})}
        end
      when ".docx"
        # Prefer pandoc for DOCX; auto-detect without requiring use_pandoc flag
        tmp_md = output_path + ".md"
        File.write(tmp_md, markdown)
        require_relative "converter/renderer/pandoc_shell"
        pandoc_path = Renderer::PandocShell.which("pandoc")
        if pandoc_path
          ok = Renderer::PandocShell.render(md_path: tmp_md, out_path: output_path, pandoc_path: pandoc_path, args: [])
          File.delete(tmp_md) if File.exist?(tmp_md)
          raise RendererUnavailableError, "pandoc failed to generate DOCX" unless ok
          {status: :ok, output_path: output_path, validation: (opts[:validate] ? Validation.validate_string(yaml_string) : {status: :ok, error: nil})}
        else
          File.delete(tmp_md) if File.exist?(tmp_md)
          raise RendererUnavailableError, "DOCX requires pandoc; install pandoc or use .md/.html/.pdf"
        end
      else
        tmp_md = output_path + ".md"
        File.write(tmp_md, markdown)
        if opts[:use_pandoc]
          require_relative "converter/renderer/pandoc_shell"
          ok = Renderer::PandocShell.render(md_path: tmp_md, out_path: output_path, pandoc_path: opts[:pandoc_path], args: opts[:pandoc_args])
          File.delete(tmp_md) if File.exist?(tmp_md)
          raise PandocNotFoundError, "pandoc not found in PATH" unless ok
          {status: :ok, output_path: output_path, validation: (opts[:validate] ? Validation.validate_string(yaml_string) : {status: :ok, error: nil})}
        else
          raise RendererUnavailableError, "Renderer for #{ext} not implemented. Pass use_pandoc: true or use .md/.html/.pdf."
        end
      end
    end
  end
end

# Extend the Version with VersionGem::Basic to provide semantic version helpers.
Yaml::Converter::Version.class_eval do
  extend VersionGem::Basic
end
