require 'rupac'

RSpec.describe "success parser" do
  passing_examples = [
    {
      parser: P.success,
      input: '1234',
      result: '',
      residual: '1234'
    },
    {
      parser: P.success,
      input: '',
      result: '',
      residual: ''
    }
  ]
  failing_examples = nil

  it_behaves_like 'a parser', passing_examples, failing_examples
end
