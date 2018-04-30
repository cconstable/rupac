require 'rupac'

RSpec.describe "whitespace parser" do
  passing_examples = [
    {
      parser: P.whitespace,
      input: ' a',
      result: ' ',
      residual: 'a'
    },
    {
      parser: P.whitespace,
      input: "\na new line",
      result: "\n",
      residual: 'a new line'
    },
    {
      parser: P.whitespace,
      input: "\ta",
      result: "\t",
      residual: 'a'
    },
    {
      parser: P.whitespace,
      input: "\va",
      result: "\v",
      residual: 'a'
    },
    {
      parser: P.whitespace,
      input: "\bhello",
      result: "\b",
      residual: 'hello'
    },
    {
      parser: P.whitespace,
      input: "\ra",
      result: "\r",
      residual: 'a'
    },
    {
      parser: P.whitespace('{'),
      input: "\n{ abc",
      result: "{",
      residual: 'abc'
    },
    {
      parser: P.whitespace('{'),
      input: "\n{abc",
      result: "{",
      residual: 'abc'
    },
    {
      parser: P.whitespace('{'),
      input: "{\nabc",
      result: "{",
      residual: 'abc'
    },
    {
      parser: P.whitespace('{'),
      input: "{",
      result: "{",
      residual: ''
    }
  ]
  failing_examples = [
    {
      parser: P.whitespace,
      input: 'abc'
    },
    {
      parser: P.whitespace,
      input: '11234'
    },
    {
      parser: P.whitespace,
      input: ''
    },
    {
      parser: P.whitespace("{"),
      input: ' '
    },
    {
      parser: P.whitespace("{"),
      input: ' [ '
    }
  ]

  it_behaves_like 'a parser', passing_examples, failing_examples
end
