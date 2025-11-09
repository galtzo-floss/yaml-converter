# frozen_string_literal: true

require "yaml"

module Yaml
  module Converter
    # YAML validation helpers.
    #
    # This module provides simple validation by attempting to parse input using
    # Psych.safe_load with a minimal, safe set of options. It does not raise on
    # failure; instead it returns a structured Hash indicating status and error.
    #
    # @see .validate_string
    # @see .validate_file
    module Validation
      module_function

      # Validate a YAML string by attempting to load it safely via Psych.
      #
      # Uses Psych.safe_load with:
      # - permitted_classes: []
      # - permitted_symbols: []
      # - aliases: true
      #
      # @param yaml_string [String] the YAML content to validate
      # @return [Hash] a result hash
      # @return [Hash] [
      #   { status: :ok, error: nil } when parsing succeeds,
      #   { status: :fail, error: Exception } when parsing fails
      # ]
      # @example Success
      #   Yaml::Converter::Validation.validate_string("foo: bar")
      #   #=> { status: :ok, error: nil }
      # @example Failure
      #   Yaml::Converter::Validation.validate_string(": : :")
      #   #=> { status: :fail, error: #<Psych::SyntaxError ...> }
      def validate_string(yaml_string)
        # Psych.safe_load requires permitted classes for complex YAML; for our purposes,
        # allow basic types and symbols off.
        Psych.safe_load(
          yaml_string,
          permitted_classes: [],
          permitted_symbols: [],
          aliases: true,
        )
        {status: :ok, error: nil}
      rescue StandardError => e
        {status: :fail, error: e}
      end

      # Validate a YAML file by reading it and delegating to {.validate_string}.
      #
      # @param path [String] filesystem path to a YAML file
      # @return [Hash] see {.validate_string}
      # @example
      #   Yaml::Converter::Validation.validate_file("config.yml")
      #   #=> { status: :ok, error: nil }
      def validate_file(path)
        content = File.read(path)
        validate_string(content)
      end
    end
  end
end
