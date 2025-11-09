# frozen_string_literal: true

require "yaml/converter"
require "yaml/converter/renderer/pandoc_shell"
require "open3"

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

  it "returns false and warns when pandoc exits non-zero", :check_output do
    File.write(tmp_md, "# heading\n\ntext")
    allow(described_class).to receive(:which).with("pandoc").and_return("/usr/bin/pandoc")
    fake_status = instance_double(Process::Status, success?: false)
    allow(Open3).to receive(:capture3).and_return(["", "pandoc error", fake_status])
    output = capture(:stderr) do
      ok = described_class.render(md_path: tmp_md, out_path: out_path, pandoc_path: nil, args: [])
      expect(ok).to be false
    end
    expect(output).to include("pandoc failed:")
  end
end
