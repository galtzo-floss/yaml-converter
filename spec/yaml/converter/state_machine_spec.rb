# frozen_string_literal: true

require "yaml/converter/parser"
require "yaml/converter/state_machine"
require "date"

RSpec.describe Yaml::Converter::StateMachine do
  subject(:sm) { described_class.new(validation_status: :ok, max_line_length: 50, truncate: true, margin_notes: :auto) }

  let(:parser) { Yaml::Converter::Parser.new }

  it "produces fenced yaml and notes" do
    tokens = parser.tokenize([
      "# Title\n",
      "foo: 1 #note: first\n",
      "bar: 2\n",
    ])
    out = sm.apply(tokens)
    expect(out).to include("```yaml")
    expect(out).to include("foo: 1")
    expect(out).to include("> NOTE: first")
  end

  it "closes fence at end" do
    tokens = parser.tokenize(["foo: 1\n"])
    out = sm.apply(tokens)
    expect(out.last).to eq("```")
  end
end
