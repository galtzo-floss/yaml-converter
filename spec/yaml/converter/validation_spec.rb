# frozen_string_literal: true

RSpec.describe Yaml::Converter::Validation do
  it "returns ok for valid YAML" do
    result = described_class.validate_string("foo: bar")
    expect(result[:status]).to be(:ok)
    expect(result[:error]).to be_nil
  end

  it "returns fail for invalid YAML" do
    result = described_class.validate_string(": : :")
    expect(result[:status]).to be(:fail)
    expect(result[:error]).to be_a(StandardError)
  end
end
