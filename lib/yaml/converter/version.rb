# frozen_string_literal: true

module Yaml
  module Converter
    # Namespace for version information.
    module Version
      # The gem version.
      # @return [String]
      VERSION = "0.1.0"
    end
    # The gem version, exposed at the root of the Yaml::Converter namespace.
    # @return [String]
    VERSION = Version::VERSION
  end
end
