# frozen_string_literal: true

require "yaml/converter"

RSpec.describe "Streaming conversion" do
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

      # Non-streaming
      res1 = Yaml::Converter.convert(input_path: in_path, output_path: out_normal, options: {streaming: false})
      expect(res1[:status]).to eq(:ok)

      # Streaming forced
      res2 = Yaml::Converter.convert(input_path: in_path, output_path: out_stream, options: {streaming: true})
      expect(res2[:status]).to eq(:ok)

      md1 = File.read(out_normal)
      md2 = File.read(out_stream)
      expect(md2).to include("```yaml")
      expect(md2).to include("> NOTE: alpha")
      expect(md2).to include("Produced by [yaml-converter]")

      # Normal and streaming should be functionally equivalent. Exact whitespace may vary minimally,
      # but for our implementations they should match byte-for-byte.
      expect(md2).to eq(md1)
    end
  end
end
