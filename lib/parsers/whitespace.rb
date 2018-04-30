require 'rupac'

module Rupac
  module Parsers
    def whitespace(string = nil)
      if string.nil?
        Combinators.many1(any(" \n\r\t\v\b\f"))
          .map { |r| r.reduce('', &:+) }
          .name("whitespace")
      else
          (whitespace > match(string) < whitespace)
          .map { |r| r.flatten.reject(&:nil?).reduce('', &:+).strip }
          .name(ParserDescriptor.parser(name:"whitespace", input:[string]))
      end
    end
  end
end
