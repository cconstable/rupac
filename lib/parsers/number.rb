require 'rupac'

module Rupac
  module Parsers
    def number
      Combinators.many1(digit)
        .map { |r| r.map(&:to_s).reduce(&:+).to_i }
        .name("number") # TODO: escape this?
        .error("Failed to parse number.")
    end
  end
end
