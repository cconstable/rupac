require 'parser'

module Rupac
  module Combinators
    def |(other)
      desc = ParserDescriptor.combinator(name: "choice", input: [self, other])
      Parser.new(desc) do |input|
        result = parse(input)
        if result.passed?
          result
        else
          other.parse(input)
        end
      end
    end
  end
end
