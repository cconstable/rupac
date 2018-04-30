require 'rupac'

module Rupac
  module Parsers
    def fail
      desc = ParserDescriptor.parser(name: "fail", input: [])
      Parser.new(desc) do |input|
        ParserResult.fail(
          residual: input,
          error: "fail()"
        )
      end
    end
  end
end
