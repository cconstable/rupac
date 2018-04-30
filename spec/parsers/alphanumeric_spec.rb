require 'rupac'
require 'exceptions/invalid_parser_input'

RSpec.describe "alphanumeric parser" do
  passing_examples = [
    {
      parser: P.alphanumeric,
      input: 'abc123 some other text',
      result: 'a',
      residual: 'bc123 some other text'
    },
    {
      parser: P.alphanumeric,
      input: '123',
      result: '1',
      residual: '23'
    },
    {
      parser: P.alphanumeric,
      input: '8',
      result: '8',
      residual: ''
    }
  ]
  failing_examples = [
    {
      parser: P.alphanumeric,
      input: '  '
    },
    {
      parser: P.alphanumeric,
      input: ''
    },
    {
      parser: P.alphanumeric,
      input: '!@$#%^'
    }
  ]

  it_behaves_like 'a parser', passing_examples, failing_examples
end
