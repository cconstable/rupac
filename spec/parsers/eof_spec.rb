require 'rupac'

RSpec.describe "eof parser" do
  passing_examples = [
    {
      parser: P.eof,
      input: '',
      result: nil,
      residual: nil
    },
    {
      parser: P.eof,
      input: "\n",
      result: nil,
      residual: nil
    }
  ]
  failing_examples = [
    {
      parser: P.eof,
      input: 'abc'
    },
    {
      parser: P.eof,
      input: "\n1"
    }
  ]

  it_behaves_like 'a parser', passing_examples, failing_examples
end
