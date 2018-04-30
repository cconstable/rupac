require 'parser'

module Rupac
  module Combinators
    def <(other)
      desc = ParserDescriptor.combinator(name: "optional_r", input: [self, other])
      Parser.new(desc) do |input|
        result1 = parse(input)
        if result1.passed?
          result2 = other.parse(result1.residual)
          if result2.passed?
            ParserResult.pass(
              result: [result1.result, result2.result],
              residual: result2.residual
            )
          else
            ParserResult.pass(
              result: [result1.result, nil],
              residual: result1.residual
            )
          end
        else
          result1
        end
      end
    end
  end
end
