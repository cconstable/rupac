require 'parser'

module Rupac
  module Combinators
    def lookahead(parser)
      desc = ParserDescriptor.combinator(name: "lookahead", input: [parser])
      Parser.new(desc) do |input|
        result = parser.parse(input)
        if result.passed?
          ParserResult.pass(
            result: "",
            residual: input
          )
        else
          result
        end
      end
    end
  end
end
