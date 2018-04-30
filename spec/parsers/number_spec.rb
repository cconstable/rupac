require 'rupac'
require 'exceptions/invalid_parser_input'

RSpec.describe "number parser" do
  passing_examples = [
    {
      parser: P.number,
      input: '1234 string',
      result: 1234,
      residual: ' string'
    },
    {
      parser: P.number,
      input: '12',
      result: 12,
      residual: ''
    }
  ]
  failing_examples = [
    {
      parser: P.number,
      input: 'abc'
    },
    {
      parser: P.number,
      input: ''
    },
    {
      parser: P.number,
      input: '!@#$%^'
    }
  ]

  it_behaves_like 'a parser', passing_examples, failing_examples
end
