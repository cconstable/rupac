require 'parser'

module Rupac
  module Combinators
    def >(other)
      desc = ParserDescriptor.combinator(name: "optional_l", input: [self, other])
      Parser.new(desc) do |input|
        result1 = parse(input)
        result2 = other.parse(result1.residual)
        if result1.passed? && result2.passed?
          ParserResult.pass(
            result: [result1.result, result2.result],
            residual: result2.residual
          )
        else
          if result2.passed?
            ParserResult.pass(
              result: [nil, result2.result],
              residual: result2.residual
            )
          else
            ParserResult.fail(
              residual: input,
              error: "... > failed"
            )
          end
        end
      end
    end
  end
end
