require 'parser'

module Rupac
  module Combinators
    def >>(other)
      flat_map do |r1|
        other.flat_map do |r2|
          Parser.pure([r1, r2])
        end
      end.name(ParserDescriptor.combinator(
        name: "sequence",
        input: [self, other])
      )
    end
  end
end
