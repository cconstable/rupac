require 'rupac'

RSpec.describe 'any_except parser' do
  passing_examples = [
    {
      parser: P.any_except('abc'),
      input: '123',
      result: '1',
      residual: '23'
    },
    {
      parser: P.any_except('a'),
      input: '123',
      result: '1',
      residual: '23'
    },
    {
      parser: P.any_except('abc'),
      input: '1a3b4c',
      result: '1',
      residual: 'a3b4c'
    },
    {
      parser: P.any_except('abc'),
      input: 'za',
      result: 'z',
      residual: 'a'
    }
  ]

  failing_examples = [
    {
      parser: P.any_except('abc'),
      input: 'a1249'
    },
    {
      parser: P.any_except('abc'),
      input: 'b'
    },
    {
      parser: P.any_except('abc'),
      input: 'cccccc'
    },
    {
      parser: P.any_except('abc'),
      input: ''
    }
  ]

  it_behaves_like 'a parser', passing_examples, failing_examples
end
