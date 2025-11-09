# frozen_string_literal: true

require "date"

module Yaml
  module Converter
    # Central configuration handling: merges explicit options with ENV and defaults.
    # Use {Yaml::Converter::Config.resolve} to obtain the finalized options hash.
    module Config
      DEFAULTS = {
        max_line_length: 70,
        truncate: true,
        margin_notes: :auto, # :auto | :inline | :ignore
        validate: true,
        use_pandoc: false,
        pandoc_args: ["-N", "--toc"],
        pandoc_path: nil,
        html_theme: :basic,
        pdf_page_size: "LETTER",
        pdf_margin: [36, 36, 36, 36], # top,right,bottom,left points (0.5")
        pdf_title_font_size: 14,
        pdf_body_font_size: 11,
        pdf_yaml_font_size: 9,
        pdf_two_column_notes: false,
        current_date: Date.today, # allows injection for deterministic tests
      }.freeze

      ENV_MAP = {
        max_line_length: "YAML_CONVERTER_MAX_LINE_LEN",
        truncate: "YAML_CONVERTER_TRUNCATE",
        margin_notes: "YAML_CONVERTER_MARGIN_NOTES",
        validate: "YAML_CONVERTER_VALIDATE",
        use_pandoc: "YAML_CONVERTER_USE_PANDOC",
        pdf_page_size: "YAML_CONVERTER_PDF_PAGE_SIZE",
        pdf_title_font_size: "YAML_CONVERTER_PDF_TITLE_FONT_SIZE",
        pdf_body_font_size: "YAML_CONVERTER_PDF_BODY_FONT_SIZE",
        pdf_yaml_font_size: "YAML_CONVERTER_PDF_YAML_FONT_SIZE",
        pdf_two_column_notes: "YAML_CONVERTER_PDF_TWO_COLUMN_NOTES",
      }.freeze

      BOOLEAN_KEYS = %i[truncate validate use_pandoc pdf_two_column_notes].freeze

      class << self
        # Merge caller options with environment overrides and defaults.
        # Environment bools accept values: 1, true, yes, on (case-insensitive).
        #
        # @param options [Hash]
        # @return [Hash] normalized options suitable for passing to emitters/renderers
        def resolve(options = {})
          opts = DEFAULTS.dup
          ENV_MAP.each do |key, env_key|
            val = ENV[env_key]
            next if val.nil?

            opts[key] = coerce_env_value(key, val)
          end
          options.each do |k, v|
            opts[k] = v unless v.nil?
          end
          normalize(opts)
        end

        # Normalize symbolic values loaded from ENV.
        # @param opts [Hash]
        # @return [Hash]
        def normalize(opts)
          opts[:margin_notes] = opts[:margin_notes].to_sym if opts[:margin_notes].is_a?(String)
          opts[:html_theme] = opts[:html_theme].to_sym if opts[:html_theme].is_a?(String)
          opts
        end

        # Coerce ENV string values into typed Ruby objects.
        # @param key [Symbol]
        # @param value [String]
        # @return [Object]
        def coerce_env_value(key, value)
          if BOOLEAN_KEYS.include?(key)
            %w[1 true yes on].include?(value.to_s.downcase)
          elsif key == :max_line_length
            value.to_i
          else
            value
          end
        end
      end
    end
  end
end
