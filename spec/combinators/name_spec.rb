require 'rupac'

RSpec.describe "name combinator" do
  it "generates a parser" do
    original_parser = P.match('a')
    new_parser = original_parser.name("matcher")
    expect(original_parser).to_not equal new_parser
  end

  it "changes the name of the parser" do
    original_parser = P.match('a')
    new_parser = original_parser.name("some random string")
    expect("#{original_parser}").to_not eq "#{new_parser}"
    expect("#{new_parser}").to eq "some random string()"
  end
end
