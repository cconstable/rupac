#!/usr/bin/env ruby

require 'bundler/setup'
require 'rupac'
require 'pp'

R = Rupac
P = Rupac::Parsers

# Parser is an applicative functor. This simply means we can map n-arity
# functions (functions taking an arbitrary number of parameters) over a parser.

add = -> x, y { x + y }

# Without using applicatives we have to curry functions ourselves or rely on
# language-specific mechanisms for transforming the functions:
add_curried = -> x { add.(10, x) }
parser = P.number.map(&add_curried)
pp parser.parse('2').result # => 12

# Using applicatives, we can "lift" a function into the applicative and
# "apply" values to it. "*" is the infix operator for "apply".
parser = R::Parser.pure(add) * R::Parser.pure(10) * P.number
pp parser.parse('5').result # => 15
