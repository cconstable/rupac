require 'parser'

module Rupac
  module Parsers
    def digit
      desc = ParserDescriptor.parser(name: "digit", input: [])
      Parser.new(desc) do |input|
        if input[0] =~ /[[:digit:]]/
          ParserResult.pass(
            result: input[0].to_i,
            residual: input[1..-1]
          )
        else
          ParserResult.fail(
            residual: input,
            error: "Failed to parse a digit from #{input}"
          )
        end
      end
    end
  end
end
