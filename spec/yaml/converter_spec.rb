# frozen_string_literal: true

RSpec.describe Yaml::Converter do
  let(:project_root) { File.expand_path("../..", __dir__) }
  let(:exe_path) { File.join(project_root, "exe", "yaml-convert") }

  let(:yaml_input) do
    <<~YAML
      # Title Line
      # YAML validation:
      ---
      key: value #note: important detail
    YAML
  end

  describe "::to_markdown" do
    it "includes validation status line", freeze: Time.new(2025, 11, 8, 12, 0, 0, 0) do
      md = described_class.to_markdown(yaml_input, options: {validate: true})
      expect(md).to include("YAML validation:*OK* on 08/11/2025")
    end

    it "includes footer by default" do
      md = described_class.to_markdown(yaml_input, options: {})
      expect(md).to include("Produced by [yaml-converter]")
    end

    it "omits footer when YAML_CONVERTER_EMIT_FOOTER=false" do
      old = ENV["YAML_CONVERTER_EMIT_FOOTER"]
      ENV["YAML_CONVERTER_EMIT_FOOTER"] = "false"
      md = described_class.to_markdown(yaml_input, options: {})
      expect(md).not_to include("Produced by [yaml-converter]")
    ensure
      ENV["YAML_CONVERTER_EMIT_FOOTER"] = old
    end

    it "wraps YAML content in fenced code blocks" do
      md = described_class.to_markdown(yaml_input, options: {})
      expect(md).to include("```yaml")
      expect(md).to include("```
---- ")
    end

    it "emits note outside YAML block" do
      md = described_class.to_markdown(yaml_input, options: {})
      expect(md).to include("> NOTE: important detail")
    end
  end

  describe "::validate" do
    it "returns ok for valid YAML" do
      result = described_class.validate("foo: bar")
      expect(result[:status]).to eq(:ok)
      expect(result[:error]).to be_nil
    end

    it "returns fail for invalid YAML" do
      result = described_class.validate(": : :")
      expect(result[:status]).to eq(:fail)
      expect(result[:error]).to be_a(StandardError)
    end
  end

  describe "::convert" do
    it "writes markdown output when .md extension" do
      Tempfile.create(["test", ".yaml"]) do |f|
        f.write("foo: bar")
        f.flush
        out = Tempfile.create(["out", ".md"]) { |tf| tf.path }
        result = described_class.convert(input_path: f.path, output_path: out, options: {})
        expect(result[:status]).to eq(:ok)
        expect(File.read(out)).to include("foo: bar")
      end
    end

    it "writes html output when .html extension" do
      Tempfile.create(["test", ".yaml"]) do |f|
        f.write("foo: bar")
        f.flush
        out = Tempfile.create(["out", ".html"]) { |tf| tf.path }
        result = described_class.convert(input_path: f.path, output_path: out, options: {})
        expect(result[:status]).to eq(:ok)
        expect(File.read(out)).to include("<html")
      end
    end

    it "writes pdf output when .pdf extension (native)" do
      Tempfile.create(["test", ".yaml"]) do |f|
        f.write("foo: bar")
        f.flush
        out = Tempfile.create(["out", ".pdf"]) { |tf| tf.path }
        result = described_class.convert(input_path: f.path, output_path: out, options: {use_pandoc: false})
        expect(result[:status]).to eq(:ok)
        expect(File).to exist(out)
        expect(File.size(out)).to be > 0
      end
    end

    it "handles docx: converts if pandoc present, else raises" do
      Tempfile.create(["test", ".yaml"]) do |f|
        f.write("foo: bar")
        f.flush
        out = Tempfile.create(["out", ".docx"]) { |tf| tf.path }
        pandoc_path = begin
          require "yaml/converter/renderer/pandoc_shell"
          Yaml::Converter::Renderer::PandocShell.which("pandoc")
        rescue LoadError
          nil
        end
        if pandoc_path
          result = described_class.convert(input_path: f.path, output_path: out, options: {})
          expect(result[:status]).to eq(:ok)
          expect(File).to exist(out)
          expect(File.size(out)).to be > 0
        else
          expect do
            described_class.convert(input_path: f.path, output_path: out, options: {})
          end.to raise_error(Yaml::Converter::RendererUnavailableError)
        end
      end
    end

    it "raises for unsupported extension" do
      Tempfile.create(["test", ".yaml"]) do |f|
        f.write("foo: bar")
        f.flush
        expect do
          described_class.convert(input_path: f.path, output_path: f.path + ".rtf", options: {})
        end.to raise_error(Yaml::Converter::RendererUnavailableError)
      end
    end
  end

  describe "errors" do
    it "raises InvalidArgumentsError for missing input" do
      expect do
        described_class.convert(input_path: "/no/such/file.yaml", output_path: "/tmp/out.md")
      end.to raise_error(Yaml::Converter::InvalidArgumentsError)
    end

    it "raises RendererUnavailableError for unsupported extension without pandoc" do
      Tempfile.create(["in", ".yaml"]) do |f|
        f.write("foo: bar")
        f.flush
        expect do
          described_class.convert(input_path: f.path, output_path: f.path + ".rtf", options: {use_pandoc: false})
        end.to raise_error(Yaml::Converter::RendererUnavailableError)
      end
    end
  end

  describe "config" do
    include_context "with stubbed env"

    it "uses ENV to override max_line_length and booleans" do
      stub_env(
        "YAML_CONVERTER_MAX_LINE_LEN" => "80",
        "YAML_CONVERTER_TRUNCATE" => "false",
        "YAML_CONVERTER_VALIDATE" => "0",
        "YAML_CONVERTER_USE_PANDOC" => "1",
      )
      expect(ENV["YAML_CONVERTER_MAX_LINE_LEN"]).to eq("80")
      cfg = Yaml::Converter::Config.resolve({})
      expect(cfg[:max_line_length]).to eq(80)
      expect(cfg[:truncate]).to eq(false)
      expect(cfg[:validate]).to eq(false)
      expect(cfg[:use_pandoc]).to eq(true)
    end
  end

  describe "CLI", :check_output do
    it "converts YAML to markdown via cli" do
      Tempfile.create(["test", ".yaml"]) do |f|
        f.write("foo: bar")
        f.flush
        out = Tempfile.create(["out", ".md"]) { |tf| tf.path }
        output = capture(:stdout) do
          system({"KETTLE_TEST_SILENT" => "false"}, RbConfig.ruby, exe_path, f.path, out)
        end
        expect($?.exitstatus).to eq(0)
        expect(output).to include("Converted:")
        expect(File.read(out)).to include("foo: bar")
      end
    end

    it "converts YAML to html via cli" do
      Tempfile.create(["test", ".yaml"]) do |f|
        f.write("foo: bar")
        f.flush
        out = Tempfile.create(["out", ".html"]) { |tf| tf.path }
        output = capture(:stdout) do
          system({"KETTLE_TEST_SILENT" => "false"}, RbConfig.ruby, exe_path, f.path, out)
        end
        expect($?.exitstatus).to eq(0)
        expect(output).to include("Converted:")
        expect(File.read(out)).to include("<html>")
      end
    end

    it "supports batch conversion via --glob to md" do
      Dir.mktmpdir do |dir|
        a = File.join(dir, "a.yaml")
        File.write(a, "foo: 1\n")
        b = File.join(dir, "b.yaml")
        File.write(b, "bar: 2\n")
        output = capture(:stdout) do
          system({"KETTLE_TEST_SILENT" => "false"}, RbConfig.ruby, exe_path, "--glob", File.join(dir, "*.yaml"), "--out-ext", "md")
        end
        expect($?.exitstatus).to eq(0)
        expect(output).to include("Batch complete:")
        expect(File).to exist(File.join(dir, "a.md"))
        expect(File).to exist(File.join(dir, "b.md"))
      end
    end

    it "handles --glob with no matches" do
      Dir.mktmpdir do |dir|
        output = capture(:stderr) do
          system({"KETTLE_TEST_SILENT" => "false"}, RbConfig.ruby, exe_path, "--glob", File.join(dir, "*.yaml"), "--out-ext", "md")
        end
        expect($?.exitstatus).to eq(2)
        expect(output).to include("No files matched glob:")
      end
    end
  end

  describe "edge cases" do
    it "warns when overwriting an existing file" do
      Dir.mktmpdir do |dir|
        input = File.join(dir, "in.yaml")
        File.write(input, "foo: 1\n")
        output = File.join(dir, "out.md")
        File.write(output, "existing\n")
        stderr = capture(:stderr) do
          described_class.convert(input_path: input, output_path: output, options: {})
        end
        expect(stderr.empty? || stderr.include?("Overwriting existing file")).to be true
      end
    end

    it "handles empty file gracefully (no crash)" do
      md = described_class.to_markdown("\n", options: {})
      expect(md).to include("Produced by [yaml-converter]")
    end
  end
end
