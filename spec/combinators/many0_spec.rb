require 'rupac'

RSpec.describe "many0 combinator" do
  passing_examples = [
    {
      parser: C.many0(P.match('a')),
      input: 'abc123 some other text',
      result: ['a'],
      residual: 'bc123 some other text'
    },
    {
      parser: C.many0(P.match('a')),
      input: 'aaabc',
      result: ['a', 'a', 'a'],
      residual: 'bc'
    },
    {
      parser: C.many0(P.match('a')),
      input: 'bcd',
      result: [''],
      residual: 'bcd'
    },
    {
      parser: C.many0(P.match('123')),
      input: '1231234',
      result: ['123', '123'],
      residual: '4'
    },
    {
      parser: C.many0(P.match(' 1 ')),
      input: ' 1 ',
      result: [' 1 '],
      residual: ''
    }
  ]
  failing_examples = nil

  it_behaves_like 'a combinator', passing_examples, failing_examples
end
