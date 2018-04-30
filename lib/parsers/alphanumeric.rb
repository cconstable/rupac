require 'rupac'

module Rupac
  module Parsers
    def alphanumeric
      desc = ParserDescriptor.parser(name: "alphanumeric", input: [])
      Parser.new(desc) do |input|
        if input[0] =~ /[[:alnum:]]/
          ParserResult.pass(
            result: input[0],
            residual: input[1..-1]
          )
        else
          ParserResult.fail(
            residual: input,
            error: "Failed to parse alphanumeric characters from: #{input}."
          )
        end
      end
    end
  end
end
