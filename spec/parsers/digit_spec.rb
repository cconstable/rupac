require 'rupac'
require 'exceptions/invalid_parser_input'

RSpec.describe "digit parser" do
  passing_examples = [
    {
      parser: P.digit,
      input: '123',
      result: 1,
      residual: '23'
    },
    {
      parser: P.digit,
      input: '1bc',
      result: 1,
      residual: 'bc'
    },
    {
      parser: P.digit,
      input: '1',
      result: 1,
      residual: ''
    }
  ]
  failing_examples = [
    {
      parser: P.digit,
      input: 'abc'
    },
    {
      parser: P.digit,
      input: ''
    },
    {
      parser: P.digit,
      input: '!$@%^'
    }
  ]

  it_behaves_like 'a parser', passing_examples, failing_examples
end
