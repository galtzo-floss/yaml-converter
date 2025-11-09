# frozen_string_literal: true

require 'yaml/converter/parser'

RSpec.describe Yaml::Converter::Parser do
  subject(:parser) { described_class.new }

  it "tokenizes titles, yaml lines, and notes" do
    tokens = parser.tokenize([
      "# Title\n",
      "foo: 1 #note: first\n",
      "bar: 2\n",
    ])
    expect(tokens.map(&:type)).to include(:title, :yaml_line, :note)
  end

  it "ignores separators" do
    tokens = parser.tokenize(["---\n"]) # just separator
    expect(tokens.map(&:type)).to include(:separator)
  end
end

