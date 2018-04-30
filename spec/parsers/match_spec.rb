require 'rupac'
require 'exceptions/invalid_parser_input'

RSpec.describe "match parser" do
  passing_examples = [
    {
      parser: P.match('a'),
      input: 'a',
      result: 'a',
      residual: ''
    },
    {
      parser: P.match('a'),
      input: 'abc',
      result: 'a',
      residual: 'bc'
    },
    {
      parser: P.match('12'),
      input: '1234',
      result: '12',
      residual: '34'
    }
  ]
  failing_examples = [
    {
      parser: P.match('z'),
      input: 'abc'
    },
    {
      parser: P.match('12'),
      input: '11234'
    },
    {
      parser: P.match('12'),
      input: ''
    }
  ]

  it_behaves_like 'a parser', passing_examples, failing_examples
end
