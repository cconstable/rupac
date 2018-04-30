require 'rupac'

RSpec.describe "any parser" do
  passing_examples = [
    {
      parser: P.any('abc'),
      input: 'abc',
      result: 'a',
      residual: 'bc'
    },
    {
      parser: P.any('abc'),
      input: 'bac',
      result: 'b',
      residual: 'ac'
    },
    {
      parser: P.any('abc'),
      input: 'cccc',
      result: 'c',
      residual: 'ccc'
    },
    {
      parser: P.any('123'),
      input: '1abc',
      result: '1',
      residual: 'abc'
    },
    {
      parser: P.any('Z'),
      input: 'Zabc',
      result: 'Z',
      residual: 'abc'
    }
  ]
  failing_examples = [
    {
      parser: P.any('abc'),
      input: 'ABC'
    },
    {
      parser: P.any('123'),
      input: '456'
    },
    {
      parser: P.any('123'),
      input: 'a'
    }
  ]

  it_behaves_like 'a parser', passing_examples, failing_examples
end
