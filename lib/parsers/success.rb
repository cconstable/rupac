require 'rupac'

module Rupac
  module Parsers
    def success
      desc = ParserDescriptor.parser(name: "success", input: [])
      Parser.new(desc) do |input|
        ParserResult.pass(
          result: "",
          residual: input
        )
      end
    end
  end
end
