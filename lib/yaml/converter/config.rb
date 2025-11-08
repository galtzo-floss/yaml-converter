# frozen_string_literal: true

module Yaml
  module Converter
    # Central configuration handling: merges explicit options with ENV and defaults.
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
      }.freeze

      ENV_MAP = {
        max_line_length: "YAML_CONVERTER_MAX_LINE_LEN",
        truncate: "YAML_CONVERTER_TRUNCATE",
        margin_notes: "YAML_CONVERTER_MARGIN_NOTES",
        validate: "YAML_CONVERTER_VALIDATE",
        use_pandoc: "YAML_CONVERTER_USE_PANDOC",
      }.freeze

      BOOLEAN_KEYS = %i[truncate validate use_pandoc].freeze

      class << self
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

        def normalize(opts)
          opts[:margin_notes] = opts[:margin_notes].to_sym if opts[:margin_notes].is_a?(String)
          opts[:html_theme] = opts[:html_theme].to_sym if opts[:html_theme].is_a?(String)
          opts
        end

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
