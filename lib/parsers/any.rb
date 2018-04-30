require 'rupac'

module Rupac
  module Parsers
    def any(string)
      string.chars
        .map { |c| match(c) }
        .reduce(&:|)
        .name(ParserDescriptor.parser(name: "any", input:[string]))
        .error("Failed to find any of the characters '#{string}' in the input.")
    end
  end
end
