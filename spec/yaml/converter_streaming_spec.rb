# frozen_string_literal: true

RSpec.describe Yaml::Converter do
  let(:input) do
    <<~YAML
      # Title
      # YAML validation:
      ---
      a: 1 #note: alpha
      b: 2
    YAML
  end

  it "produces the same markdown as non-streaming for small input when forced" do
    Dir.mktmpdir do |dir|
      in_path = File.join(dir, "in.yaml")
      File.write(in_path, input)
      out_stream = File.join(dir, "out_stream.md")
      out_normal = File.join(dir, "out_normal.md")

      res1 = described_class.convert(input_path: in_path, output_path: out_normal, options: {streaming: false})
      expect(res1[:status]).to be(:ok)

      res2 = described_class.convert(input_path: in_path, output_path: out_stream, options: {streaming: true})
      expect(res2[:status]).to be(:ok)

      md1 = File.read(out_normal)
      md2 = File.read(out_stream)
      expect(md2).to include("```yaml")
      expect(md2).to include("> NOTE: alpha")
      expect(md2).to include("Produced by [yaml-converter]")
      expect(md2).to eq(md1)
    end
  end
end

