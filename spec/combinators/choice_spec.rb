require 'rupac'

RSpec.describe "| (choice) combinator" do
  passing_examples = [
    {
      parser: P.match('a') | P.match('b'),
      input: 'abc123 some other text',
      result: 'a',
      residual: 'bc123 some other text'
    },
    {
      parser: P.match('a') | P.match('bb') | P.match('ccc'),
      input: 'bbcccdddd',
      result: 'bb',
      residual: 'cccdddd'
    },
    {
      parser: P.match('123') | P.match('4'),
      input: '1234',
      result: '123',
      residual: '4'
    }
  ]
  failing_examples = [
    {
      parser: P.match('a') | P.match('b'),
      input: 'c'
    },
    {
      parser: P.match('aa') | P.match('bb'),
      input: 'abab'
    },
    {
      parser: P.match('a') | P.match('b') | P.match('c'),
      input: 'dcba'
    },
    {
      parser: P.match('a') | P.match('b'),
      input: ''
    }
  ]

  it_behaves_like 'a combinator', passing_examples, failing_examples
end
