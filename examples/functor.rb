#!/usr/bin/env ruby

require 'bundler/setup'
require 'rupac'
require 'pp'

R = Rupac
P = Rupac::Parsers

# Parser is a functor. This means we can map the parsed result to a new type.

# Without map, transforming the output of a parser is verbose:
parser = R::Parser.new do |input|
  inner_parser = P.alphanumeric
  result = inner_parser.parse('a')
  if result.passed?
    R::ParserResult.pass(
      result: result.result.capitalize,
      residual: result.residual
    )
  else
    result
  end
end
pp parser.parse('a').result # => 'A'

# With map, it is trivial:
parser = P.alphanumeric.map(&:capitalize)
pp parser.parse('a').result # => 'A'
