# frozen_string_literal: true

require "yaml/converter/renderer/pdf_hexapdf"

RSpec.describe Yaml::Converter::Renderer::PdfHexapdf do
  it "generates a simple PDF from markdown" do
    markdown = <<~MD
      # Title

      ```yaml
      key: value
      ```

      > NOTE: important
    MD
    out = Tempfile.create(["out", ".pdf"]) { |f| f.path }
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
    out = Tempfile.create(["out", ".pdf"]) { |f| f.path }
    ok = described_class.render(markdown: markdown, out_path: out, options: {pdf_two_column_notes: true})
    expect(ok).to be true
    expect(File).to exist(out)
    expect(File.size(out)).to be > 0
  end

  [false, true].each do |two_columns|
    it "preserves overflowing YAML and notes with two-column layout #{two_columns}" do
      yaml = (1..180).map { |n| "key#{n}: value#{n}" }.join("\n")
      notes = (1..120).map { |n| "> NOTE: note#{n}" }.join("\n")
      markdown = "# Title\n\n```yaml\n#{yaml}\n```\n\n#{notes}\n"
      Tempfile.create(["out", ".pdf"]) do |file|
        expect(described_class.render(markdown: markdown, out_path: file.path,
          options: {pdf_two_column_notes: two_columns})).to be true
        document = HexaPDF::Document.open(file.path)
        pages = document.pages.to_a
        text = pages.map(&:extract_text).join("\n")
        expect(pages.length).to be > 1
        expect(text).to include("key180: value180", "NOTE: note120")
        expect(pages.last.extract_text).to include("Page #{pages.length} of #{pages.length}")
      end
    end
  end
end
