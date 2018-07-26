require 'parser'

module Rupac
  module Combinators
    def skip_to(parser)
      desc = ParserDescriptor.combinator(name: "skip_to", input: [parser])
      Parser.new(desc) do |input|
        result = parser.parse(input)
        input = input[1..-1] if input.length > 1
        while result.failed? do
          result = parser.parse(input)
          if input.length > 1
            input = input[1..-1]
          else
            break
          end
        end

        result
      end
    end
  end
end
