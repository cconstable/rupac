require 'rupac'

RSpec.describe Rupac::ParserDescriptor do
  it "has a parser constructor that properly escapes input" do
    descriptor = Rupac::ParserDescriptor.parser(name: "myParser", input:['"'])
    expect(descriptor.to_s).to eq 'myParser("\"")'
  end

  it "has a combinator constructor" do
    descriptor = Rupac::ParserDescriptor.combinator(name: "myCombinator", input:["someInput"])
    expect(descriptor.to_s).to eq 'myCombinator(someInput)'
  end

  it "can be converted to a string" do
    name = "i3rfh2o183f0q3"
    descriptor = Rupac::ParserDescriptor.new(name)
    expect(descriptor.to_s).to eq name
  end
end
