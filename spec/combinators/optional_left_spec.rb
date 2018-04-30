require 'rupac'

RSpec.describe "> (optional left) combinator" do
  passing_examples = [
    {
      parser: P.match('a') > P.match('b'),
      input: 'abc',
      result: ['a', 'b'],
      residual: 'c'
    },
    {
      parser: P.match('a') > P.match('b'),
      input: 'bc',
      result: [nil, 'b'],
      residual: 'c'
    },
    {
      parser: P.match('a') > P.match('b') > P.match('c'),
      input: 'abc',
      result: [['a', 'b'], 'c'],
      residual: ''
    },
    {
      parser: P.match('a') > P.match('b') > P.match('c'),
      input: 'bc',
      result: [[nil, 'b'], 'c'],
      residual: ''
    },
    {
      parser: P.match('a') > P.match('b') > P.match('c'),
      input: 'c',
      result: [nil, 'c'],
      residual: ''
    }
  ]
  failing_examples = [
    {
      parser: P.match('a') > P.match('b'),
      input: 'cab'
    },
    {
      parser: P.match('a') > P.match('b') > P.match('c'),
      input: 'dabc'
    },
    {
      parser: P.match('a') > P.match('b'),
      input: 'a'
    },
    {
      parser: P.match('a') > P.match('b'),
      input: ''
    }
  ]

  it_behaves_like 'a combinator', passing_examples, failing_examples
end
