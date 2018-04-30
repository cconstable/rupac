require 'rupac'
require 'exceptions/invalid_parser_input'

RSpec.describe "quoted string parser" do
  passing_examples = [
    {
      parser: P.quoted_string,
      input: '"a quoted string" and some other text',
      result: 'a quoted string',
      residual: ' and some other text'
    }
  ]
  failing_examples = [
    {
      parser: P.quoted_string,
      input: 'abc'
    },
    {
      parser: P.quoted_string,
      input: ''
    }
  ]

  it_behaves_like 'a parser', passing_examples, failing_examples
end
