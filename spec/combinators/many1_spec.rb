require 'rupac'

RSpec.describe "many1 combinator" do
  passing_examples = [
    {
      parser: C.many1(P.match('a')),
      input: 'abc123 some other text',
      result: ['a'],
      residual: 'bc123 some other text'
    },
    {
      parser: C.many1(P.match('a')),
      input: 'aaabc',
      result: ['a', 'a', 'a'],
      residual: 'bc'
    },
    {
      parser: C.many1(P.match('abcd')),
      input: 'abcd',
      result: ['abcd'],
      residual: ''
    },
    {
      parser: C.many1(P.match('123')),
      input: '1231234',
      result: ['123', '123'],
      residual: '4'
    },
    {
      parser: C.many1(P.match(' 1 ')),
      input: ' 1 ',
      result: [' 1 '],
      residual: ''
    },
    {
      parser: C.many1(C.many1(P.match('a'))),
      input: 'aaa',
      result: [["a", "a", "a"]],
      residual: ''
    }
  ]
  failing_examples = [
    {
      parser: C.many1(P.match('a')),
      input: 'b'
    },
    {
      parser: C.many1(P.match('ab')),
      input: 'bab'
    },
    {
      parser: C.many1(P.match('1')),
      input: ''
    },
    {
      parser: C.many1(C.many1(P.match('b'))),
      input: 'aaa'
    }
  ]

  it_behaves_like 'a combinator', passing_examples, failing_examples
end
