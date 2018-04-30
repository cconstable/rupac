require 'rupac'

RSpec.describe "< (optional right) combinator" do
  passing_examples = [
    {
      parser: P.match('a') < P.match('b'),
      input: 'abc',
      result: ['a', 'b'],
      residual: 'c'
    },
    {
      parser: P.match('a') < P.match('b'),
      input: 'acb',
      result: ['a', nil],
      residual: 'cb'
    },
    {
      parser: P.match('a') < P.match('b') < P.match('c'),
      input: 'abcd',
      result: [['a', 'b'], 'c'],
      residual: 'd'
    },
    {
      parser: P.match('a') < P.match('b') < P.match('c'),
      input: 'abbc',
      result: [['a', 'b'], nil],
      residual: 'bc'
    },
    {
      parser: P.match('a') < P.match('a') < P.match('a'),
      input: 'aaa',
      result: [['a', 'a'], 'a'],
      residual: ''
    }
  ]
  failing_examples = [
    {
      parser: P.match('a') < P.match('b'),
      input: 'cab'
    },
    {
      parser: P.match('a') < P.match('b') < P.match('c'),
      input: 'dabc'
    },
    {
      parser: P.match('a') < P.match('b'),
      input: 'b'
    },
    {
      parser: P.match('a') < P.match('b'),
      input: ''
    }
  ]

  it_behaves_like 'a combinator', passing_examples, failing_examples
end
