require 'rupac'

RSpec.describe Rupac::ParserResult do
  it "can be converted to a string" do
    result = Rupac::ParserResult.pass(
      result: "abc",
      residual: "def"
    )
    expect(result.to_s).to eq "ParserResult\n  success: true\n  result: abc\n  residual: def\n  error:"

    result = Rupac::ParserResult.fail(
      residual: "def",
      error: "some error message"
    )
    expect(result.to_s).to eq "ParserResult\n  success: false\n  result: \n  residual: def\n  error:some error message"
  end

  context "has a pass constructor that" do
    it "contains a result" do
      result = Rupac::ParserResult.pass(
        result: "abc",
        residual: "def"
      )
      expect(result.result).to eq "abc"
    end

    it "contains a residual" do
      result = Rupac::ParserResult.pass(
        result: "abc",
        residual: "def"
      )
      expect(result.residual).to eq "def"
    end
  end

  context "has a fail constructor that" do
    it "contains a residual" do
      result = Rupac::ParserResult.fail(
        residual: "def",
        error: "some error message"
      )
      expect(result.residual).to eq "def"
    end

    it "contains a residual" do
      result = Rupac::ParserResult.fail(
        residual: "def",
        error: "some error message"
      )
      expect(result.error).to eq "some error message"
    end
  end
end
