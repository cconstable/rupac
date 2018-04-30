require 'rupac'

RSpec.describe ">> (sequence) combinator" do
  passing_examples = [
    {
      parser: P.match('a') >> P.match('b'),
      input: 'abc123 some other text',
      result: ['a', 'b'],
      residual: 'c123 some other text'
    },
    {
      parser: P.match('a') >> P.match('bb') >> P.match('ccc'),
      input: 'abbcccdddd',
      result: [['a', 'bb'], 'ccc'],
      residual: 'dddd'
    },
    {
      parser: P.match('123') >> P.match('4'),
      input: '1234',
      result: ['123', '4'],
      residual: ''
    }
  ]
  failing_examples = [
    {
      parser: P.match('a') >> P.match('b'),
      input: 'aab',
      residual: 'ab'
    },
    {
      parser: P.match('aa') >> P.match('bb'),
      input: 'aab',
      residual: 'b'
    },
    {
      parser: P.match('a') >> P.match('b') >> P.match('c'),
      input: 'abab',
      residual: 'ab'
    },
    {
      parser: P.match('a') >> P.match('b'),
      input: ''
    }
  ]

  it_behaves_like 'a combinator', passing_examples, failing_examples
end
