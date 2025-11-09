# frozen_string_literal: true

require 'yaml/converter'
require 'yaml/converter/renderer/pdf_prawn'

RSpec.describe Yaml::Converter::Renderer::PdfPrawn do
  it "generates a simple PDF from markdown" do
    markdown = <<~MD
      # Title

      ```yaml
      key: value
      ```

      > NOTE: important
    MD
    out = Tempfile.create(['out', '.pdf']) { |f| f.path }
    ok = described_class.render(markdown: markdown, out_path: out, options: {})
    expect(ok).to be true
    expect(File).to exist(out)
    expect(File.size(out)).to be > 0
  end

  it "generates PDF with two-column notes layout when enabled" do
    markdown = <<~MD
      # Title

      ```yaml
      key: value
      ```

      > NOTE: important
      > NOTE: also important
    MD
    out = Tempfile.create(['out', '.pdf']) { |f| f.path }
    ok = described_class.render(markdown: markdown, out_path: out, options: { pdf_two_column_notes: true })
    expect(ok).to be true
    expect(File).to exist(out)
    expect(File.size(out)).to be > 0
  end
end
