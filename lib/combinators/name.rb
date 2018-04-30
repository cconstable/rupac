require 'rupac'

module Rupac
  module Combinators
    def name(name)
      desc = nil
      if name.is_a? ParserDescriptor
        desc = name
      else
        desc = ParserDescriptor.combinator(name: name)
      end
      Parser.new(desc) do |input|
        parse(input)
      end
    end
  end
end
