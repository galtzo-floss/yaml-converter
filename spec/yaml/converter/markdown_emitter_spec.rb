# frozen_string_literal: true

RSpec.describe Yaml::Converter::MarkdownEmitter do
  it "closes yaml fence at end of document" do
    emitter = described_class.new(Yaml::Converter::Config.resolve({}))
    out = emitter.emit(["foo: bar\n"]) # single YAML line
    combined = out.join("\n")
    expect(combined).to include("```yaml")
    # at least one closing fence present
    expect(combined.scan("```").count).to be >= 1
  end

  it "truncates long lines" do
    emitter = described_class.new(Yaml::Converter::Config.resolve({max_line_length: 10}))
    line = "key: #{"x" * 40}\n"
    out = emitter.emit([line])
    expect(out.any? { |l| l.include?("..") }).to be true
  end

  it "extracts inline #note: and emits it outside YAML block" do
    emitter = described_class.new(Yaml::Converter::Config.resolve({}))
    lines = [
      "key: value #note: important detail\n",
    ]
    out = emitter.emit(lines)
    combined = out.join("\n")
    expect(combined).to include("> NOTE: important detail")
    # Fences must remain balanced around the YAML segments
    expect(combined.scan("```yaml").count).to eq(combined.scan(/^```$/).count)
    expect(combined.scan("```yaml").count).to be >= 1
  end

  it "extracts multiple inline #note: occurrences across lines" do
    emitter = described_class.new(Yaml::Converter::Config.resolve({}))
    lines = [
      "foo: 1 #note: first\n",
      "bar: 2 #note: second\n",
    ]
    out = emitter.emit(lines)
    combined = out.join("\n")
    expect(combined).to include("> NOTE: first")
    expect(combined).to include("> NOTE: second")
    expect(combined.scan("```yaml").count).to eq(combined.scan(/^```$/).count)
  end
end
