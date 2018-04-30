require 'rupac'

RSpec.describe "fail parser" do
  passing_examples = nil
  failing_examples = [
    {
      parser: P.fail,
      input: '1234'
    },
    {
      parser: P.fail,
      input: ''
    }
  ]

  it_behaves_like 'a parser', passing_examples, failing_examples
end
