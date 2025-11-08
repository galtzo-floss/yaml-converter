# frozen_string_literal: true

require 'open3'

module Yaml
  module Converter
    module Renderer
      # Shells out to pandoc to convert markdown to target format.
      module PandocShell
        module_function

        def which(cmd)
          ENV["PATH"].split(File::PATH_SEPARATOR).each do |path|
            exe = File.join(path, cmd)
            return exe if File.executable?(exe)
          end
          nil
        end

        # @param md_path [String] path to markdown file
        # @param out_path [String] desired output file path with extension
        # @param pandoc_path [String,nil] override path to pandoc binary
        # @param args [Array<String>] extra pandoc arguments
        # @return [Boolean] true if successful
        def render(md_path:, out_path:, pandoc_path: nil, args: [])
          bin = pandoc_path || which('pandoc')
          return false unless bin
          cmd = [bin] + args + ['-o', out_path, md_path]
          _stdout, stderr, status = Open3.capture3(*cmd)
          unless status.success?
            warn("pandoc failed: #{stderr}")
            return false
          end
          true
        end
      end
    end
  end
end

