require 'rupac'

RSpec.describe "error combinator" do
  it "generates a parser" do
    original_parser = P.match('a')
    new_parser = original_parser.error("matcher error")
    expect(original_parser).to_not equal new_parser
  end

  it "does not change the normal output of the parser" do
    parser = P.match('a').error("some random string")
    result = parser.parse('abc')
    expect(result.passed?).to be_truthy
    expect(result.result).to eq 'a'
    expect(result.residual).to eq 'bc'
  end

  it "changes the error of the parser" do
    original_parser = P.match('a')
    new_parser = original_parser.error("some random string")
    original_result = original_parser.parse('b')
    new_result = new_parser.parse('b')
    expect(original_result.error).to_not eq new_result.error
    expect(new_result.error).to eq "some random string"
  end
end
