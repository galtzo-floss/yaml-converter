# frozen_string_literal: true

RSpec.describe Yaml::Converter do
  it "wraps markdown into an HTML document with note class when notes present" do
    input = <<~YAML
      # Title Line
      # YAML validation:
      ---
      key: value #note: important detail
    YAML
    Dir.mktmpdir do |dir|
      in_path = File.join(dir, "in.yaml")
      File.write(in_path, input)
      out_path = File.join(dir, "out.html")
      result = described_class.convert(input_path: in_path, output_path: out_path, options: {})
      expect(result[:status]).to be(:ok)
      html = File.read(out_path)
      expect(html).to include('<blockquote class="yaml-note">')
      expect(html).to include("NOTE: important detail")
      expect(html).to include('<code class="language-yaml">')
    end
  end
end
