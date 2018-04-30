#!/usr/bin/env ruby

require 'bundler/setup'
require 'rupac'

P = Rupac::Parsers

# Parser is a monad. This has a number of interesting applications as it allows
# the input of one parser to depend on the output of another. For example,
# knowing that Parser is a monad allows us to implement the "sequence" operator
# by simply "binding" two parsers together:

def sequence(p1, p2)
  p1.flat_map do |a|
    p2.flat_map do |b|
      Rupac::Parser.pure([a, b])
    end
  end
end

parser1 = sequence(P.match('a'), P.match('b'))
parser2 = P.match('a') >> P.match('b')
result1 = parser1.parse('abcde')
result2 = parser2.parse('abcde')

puts
puts "Calling flat_map is \"sequencing\" parsers:"
puts "#{result1.result} == #{result2.result}"
