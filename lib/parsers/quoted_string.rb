require 'rupac'

module Rupac
  module Parsers
    def quoted_string
      parser = match('"') >> Combinators.many0(match('\"') | any_except('"')) >> match('"')
      parser
        .map { |r| r.flatten[1..-2].reduce(&:+) }
        .name("quoted_string") # TODO: Escape this?
        .error("Failed to parse quoted string")
    end
  end
end
