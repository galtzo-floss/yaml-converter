# frozen_string_literal: true

require "yaml"

module Yaml
  module Converter
    module Validation
      module_function

      # Validate YAML by attempting to load it safely.
      # Returns a Hash: { status: :ok|:fail, error: Exception|nil }
      def validate_string(yaml_string)
        begin
          # Psych.safe_load requires permitted classes for complex YAML; for our purposes,
          # allow basic types and symbols off.
          Psych.safe_load(
            yaml_string,
            permitted_classes: [],
            permitted_symbols: [],
            aliases: true
          )
          { status: :ok, error: nil }
        rescue StandardError => e
          { status: :fail, error: e }
        end
      end

      def validate_file(path)
        content = File.read(path)
        validate_string(content)
      end
    end
  end
end

