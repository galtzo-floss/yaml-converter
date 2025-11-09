# frozen_string_literal: true

require 'yaml/converter'

RSpec.describe 'Errors' do
  it 'defines custom error hierarchy' do
    expect(Yaml::Converter::InvalidArgumentsError.new).to be_a(Yaml::Converter::Error)
    expect(Yaml::Converter::RendererUnavailableError.new).to be_a(Yaml::Converter::Error)
    expect(Yaml::Converter::PandocNotFoundError.new).to be_a(Yaml::Converter::Error)
  end

  it 'raises InvalidArgumentsError on missing input' do
    expect {
      Yaml::Converter.convert(input_path: '/no/such/file.yaml', output_path: '/tmp/x.md')
    }.to raise_error(Yaml::Converter::InvalidArgumentsError)
  end
end

