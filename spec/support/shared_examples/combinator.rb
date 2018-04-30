require 'rupac'

RSpec.shared_examples_for "a combinator" do |passing_examples, failing_examples|
  unless passing_examples.nil? || passing_examples.empty?
    context "should successfully parse" do
      passing_examples.each do |example|
        parser    = example[:parser]
        input     = example[:input]
        result    = example[:result]
        residual  = example[:residual]

        actual_result = parser.parse(input)

        context "#{parser}.parse('#{input}')" do
          it "and return success: true" do
            expect(actual_result.passed?).to be_truthy
          end

          it "with a result of '#{result}'" do
            expect(actual_result.result).to eq result
          end

          it "with a residual of '#{residual}'" do
            expect(actual_result.residual).to eq residual
          end
        end
      end
    end
  end

  unless failing_examples.nil? || failing_examples.empty?
    context "should fail to parse" do
      failing_examples.each do |example|
        parser    = example[:parser]
        input     = example[:input]
        actual_result = parser.parse(input)
        residual = example[:residual] || input

        context "#{parser}.parse('#{input}')]" do
          it "and return success: false" do
            expect(actual_result.passed?).to be_falsey
          end

          it "with a residual of '#{input}'" do
            expect(actual_result.residual).to eq residual
          end
        end
      end
    end
  end
end
