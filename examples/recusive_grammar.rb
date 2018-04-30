#!/usr/bin/env ruby

require 'bundler/setup'
require 'rupac'
require 'pp'

# A recursive grammar for tuples
grammar = Grammar.new do
  rule(:value) { quoted_string | number | rule(:tuple) }
  rule(:tuple) { match('(') >> rule(:value) >> match(',') >> rule(:value) >> match(')') }

  rule(:tuple)
end

pp grammar.parse("(1,2)")              # => pass
pp grammar.parse("((1,2),((3,4),5))")  # => pass
pp grammar.parse("((1,2)")             # => fail
