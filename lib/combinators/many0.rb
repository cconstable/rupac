require 'parser'

module Rupac
  module Combinators
    def many0(parser)
      desc = ParserDescriptor.combinator(name: "many0", input: [parser])
      Parser.new(desc) do |input|
        (many1(parser) | Parsers.success.map { |r| [r] }).parse(input)
      end
    end
  end
end
