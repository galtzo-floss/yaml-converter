# frozen_string_literal: true

RSpec.describe Yaml::Converter do
  let(:yaml_input) do
    <<~YAML
      # Title Line
      # YAML validation:
      ---
      key: value #note: important detail
    YAML
  end

  describe "::to_markdown" do
    it "includes validation status line" do
      md = described_class.to_markdown(yaml_input, options: { validate: true })
      expect(md).to include("YAML validation:*OK* ")
    end

    it "wraps YAML content in fenced code blocks" do
      md = described_class.to_markdown(yaml_input, options: {})
      expect(md).to include("```yaml")
      expect(md).to include("```\n---- ")
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
        expect(File.read(out)).to include("<html") # kramdown wraps in HTML root
      end
    end

    it "raises for unsupported extension" do
      Tempfile.create(["test", ".yaml"]) do |f|
        f.write("foo: bar")
        f.flush
        expect do
          described_class.convert(input_path: f.path, output_path: f.path + ".pdf", options: {})
        end.to raise_error(Yaml::Converter::RendererUnavailableError)
      end
    end
  end
end
