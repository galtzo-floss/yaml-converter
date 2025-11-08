# frozen_string_literal: true

require_relative "converter/version"

module Yaml
  module Converter
    class Error < StandardError; end
    # Your code goes here...
  end
end

# Extend the Version with VersionGem::Basic to provide semantic version helpers.
Yaml::Converter::Version.class_eval do
  extend VersionGem::Basic
end
