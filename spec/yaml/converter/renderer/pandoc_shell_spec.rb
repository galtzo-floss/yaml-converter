# frozen_string_literal: true

require 'yaml/converter'
require 'yaml/converter/renderer/pandoc_shell'

RSpec.describe Yaml::Converter::Renderer::PandocShell do
  let(:tmp_md) { Tempfile.create(["pandoc_test", ".md"]) { |f| f.path } }
  let(:out_path) { Tempfile.create(["pandoc_out", ".html"]) { |f| f.path } }

  it "skips when pandoc is not available" do
    unless described_class.which("pandoc")
      skip "pandoc not installed; skipping renderer integration test"
    end
    File.write(tmp_md, "# heading\n\ntext")
    ok = described_class.render(md_path: tmp_md, out_path: out_path, pandoc_path: nil, args: [])
    expect(ok).to be true
    expect(File).to exist(out_path)
    expect(File.read(out_path)).to match(/heading/i)
  end
end
