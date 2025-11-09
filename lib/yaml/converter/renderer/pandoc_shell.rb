# frozen_string_literal: true

require "open3"

module Yaml
  module Converter
    module Renderer
      # Shells out to pandoc to convert markdown to target format.
      # Provides lightweight detection of pandoc and execution with arbitrary arguments.
      #
      # @example Convert markdown to PDF
      #   Yaml::Converter::Renderer::PandocShell.render(
      #     md_path: 'doc.md', out_path: 'doc.pdf', args: ['-N', '--toc']
      #   )
      module PandocShell
        module_function

        # Locate an executable in the current PATH.
        # @param cmd [String] command name, e.g. 'pandoc'
        # @return [String,nil] full path if found, otherwise nil
        def which(cmd)
          ENV["PATH"].split(File::PATH_SEPARATOR).each do |path|
            exe = File.join(path, cmd)
            return exe if File.executable?(exe)
          end
          nil
        end

        # Invoke pandoc to convert markdown file to another format.
        #
        # @param md_path [String] path to markdown file
        # @param out_path [String] desired output file path with extension
        # @param pandoc_path [String,nil] override path to pandoc binary (auto-detected if nil)
        # @param args [Array<String>] extra pandoc arguments (e.g. ['-N','--toc'])
        # @return [Boolean] true if successful, false otherwise
        # @example Basic HTML conversion
        #   Yaml::Converter::Renderer::PandocShell.render(
        #     md_path: 'in.md', out_path: 'out.html'
        #   )
        def render(md_path:, out_path:, pandoc_path: nil, args: [])
          bin = pandoc_path || which("pandoc")
          return false unless bin
          cmd = [bin] + args + ["-o", out_path, md_path]
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
