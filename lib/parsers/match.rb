require 'rupac'

module Rupac
  module Parsers
    def match(string)
      desc = ParserDescriptor.parser(name: "match", input: [string])
      Parser.new(desc) do |input|
        if input.length < string.length
          ParserResult.fail(
            residual: input,
            error: "Failed to match string '#{string}' in '#{input}'"
          )
        elsif input.start_with? string
          ParserResult.pass(
            result: string,
            residual: input[string.length..-1]
          )
        else
          ParserResult.fail(
            residual: input,
            error: "Failed to match string '#{string}' in '#{input}'"
          )
        end
      end
    end
  end
end
