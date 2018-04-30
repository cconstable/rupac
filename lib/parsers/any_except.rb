require 'rupac'

module Rupac
  module Parsers
    def any_except(string)
      desc = ParserDescriptor.parser(name: "any_except", input: [string])
      Parser.new(desc) do |input|
        if input.length == 0
          ParserResult.fail(
            residual: "",
            error: "Failed to find any input: input string is empty."
          )
        else
          result = Combinators.lookahead(any(string)).parse(input)
          if result.passed?
            ParserResult.fail(
              residual: input,
              error: "Expecting any input not contained in '#{string}' but found #{result.result}"
            )
          else
            ParserResult.pass(
              result: input[0],
              residual: input[1..-1]
            )
          end
        end
      end
    end
  end
end
