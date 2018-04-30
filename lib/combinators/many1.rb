require 'parser'

module Rupac
  module Combinators
    def many1(parser)
      desc = ParserDescriptor.combinator(name: "many1", input: [parser])
      Parser.new(desc) do |input|
        combined_parser_result = []
        combined_parser_result << parser.parse(input)
        while combined_parser_result.last.passed? do
          combined_parser_result << parser.parse(combined_parser_result.last.residual)
        end

        if combined_parser_result.first.failed?
          ParserResult.fail(
            residual: input,
            error: "Unable to find any #{parser} occurrences in #{input}"
          )
        else
          combined_parser_result.pop
          actual_result = combined_parser_result.reduce([]) do |acc, r|
            acc << r.result
          end
          ParserResult.pass(
            result: actual_result,
            residual: combined_parser_result.last.residual
          )
        end
      end
    end
  end
end
