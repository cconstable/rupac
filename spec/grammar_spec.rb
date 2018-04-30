require 'rupac'

# The Grammar spec is more of a set of systems or integration tests
# that ensures the entire library is functioning properly.
RSpec.describe Grammar do
  it "can construct a grammar for parsing json" do
    block = Proc.new do
      Grammar.new do
        rule(:true)           { match('true') }
        rule(:false)          { match('false') }
        rule(:null)           { match('null') }
        rule(:key)            { quoted_string }
        rule(:value)          { quoted_string | number | rule(:true) | rule(:false) | rule(:null) |rule(:json) }
        rule(:pair)           { rule(:key) >> whitespace(':') >> rule(:value) }
        rule(:hash_member)    { rule(:pair) < (whitespace(',') >> rule(:hash_member)) }
        rule(:hash)           { (whitespace('{') < rule(:hash_member)) >> whitespace('}') }
        rule(:array_element)  { rule(:value) < (whitespace(',') >> rule(:array_element)) }
        rule(:array)          { (whitespace('[') < rule(:array_element)) >> whitespace(']') }
        rule(:json)           { rule(:hash) | rule(:array) }
        rule(:json)
      end
    end
    expect(block).not_to raise_error
  end

  it "has a process_rules block that simply maps rule combinators" do
    grammar = Grammar.new do
      rule(:number) { number }
      rule(:root)   { quoted_string | rule(:number) }
      rule(:root)
    end

    grammar.process_rules do
      process(:number) { |v| v * 2 }
    end

    expect(grammar.parse("1").result).to eq 2
    expect(grammar.parse("8").result).to eq 16
    expect(grammar.parse("30").result).to eq 60
  end

  it "can be output as a string of rules" do
    grammar = Grammar.new do
      rule(:first_name) { many1(alphanumeric) }
      rule(:last_name)  { many1(alphanumeric) }
      rule(:full_name)  { rule(:first_name) >> whitespace >> rule(:last_name) }

      rule(:full_name)
    end

    expect(grammar.to_s).to eq "first_name: many1(alphanumeric())\nlast_name: many1(alphanumeric())\nfull_name: sequence(sequence(rule(\"first_name\"),whitespace()),rule(\"last_name\"))"
  end
end
