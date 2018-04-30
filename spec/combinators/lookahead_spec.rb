require 'rupac'

RSpec.describe "lookahead combinator" do
  passing_examples = [
    {
      parser: C.lookahead(P.match('a')),
      input: 'abc123 some other text',
      result: '',
      residual: 'abc123 some other text'
    },
    {
      parser: C.lookahead(P.match('1234')),
      input: '12345',
      result: '',
      residual: '12345'
    },
    {
      parser: C.lookahead(P.match(' ')),
      input: ' ',
      result: '',
      residual: ' '
    }
  ]
  failing_examples = [
    {
      parser: C.lookahead(P.match('a')),
      input: 'b'
    },
    {
      parser: C.lookahead(P.match('123')),
      input: '234'
    },
    {
      parser: C.lookahead(P.match('123')),
      input: ''
    }
  ]

  it_behaves_like 'a combinator', passing_examples, failing_examples
end
