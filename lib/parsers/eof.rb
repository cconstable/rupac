require 'parser'

module Rupac
  module Parsers
    def eof
      desc = ParserDescriptor.parser(name: "eof", input: [])
      Parser.new(desc) do |input|
        if input.strip.empty?
          ParserResult.pass(
            result: nil,
            residual: nil
          )
        else
          ParserResult.fail(
            residual: input,
            error: "Expecting EOF but there was non-whitespace input remaining: #{input}"
          )
        end
      end
    end
  end
end
