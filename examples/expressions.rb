#!/usr/bin/env ruby

require 'bundler/setup'
require 'rupac'
require 'pp'

# Parser combinators can be used build compilers for programming languages. In
# particular, they can act as a lexer and parser for the compiler front-end.
# Here is an example lexer that tokenizes expressions that look like this:
#   let x = 1 + 1
#   let y = 4 * 2 - 1

grammar = Grammar.new do
  rule(:equal)          { whitespace('=') }
  rule(:addition)       { whitespace('+') }
  rule(:subtraction)    { whitespace('-') }
  rule(:multiplication) { whitespace('*') }
  rule(:division)       { whitespace('/') }

  rule(:numeric_binary_operator) { rule(:addition) | rule(:subtraction) | rule(:multiplication) | rule(:division) }

  rule(:constant_name)  { many1(alphanumeric | any('_-')) }
  rule(:let_expression) { whitespace('let') >> rule(:constant_name) >> rule(:equal) >> rule(:arithmatic_expression) }
  rule(:arithmatic_expression) { number < (rule(:numeric_binary_operator) >> rule(:arithmatic_expression)) }
  rule(:expressions) { many1(rule(:let_expression)) }

  rule(:expressions)
end

# Now that we've broken our input into meaningful tokens, we can add processing
# rules to form the abstract syntax tree (AST):

grammar.process_rules do
  process(:constant_name) do |v|
    v.flatten.join
  end

  process(:let_expression) do |v|
    {
      exp_type: 'let',
      payload: {
        const_name: v[0][0][1],
        exp: v[1]
      }
    }
  end

  process(:arithmatic_expression) do |v|
    v = v.flatten.reject(&:nil?)
    if v.length == 1
      {
        exp_type: 'arithmatic_constant',
        payload: {
          input1: v[0]
        }
      }
    else
      {
        exp_type: 'arithmatic',
        payload: {
          input1: v[0],
          operator: v[1],
          input2: v[2]
        }
      }
    end
  end
end

# We can now generate AST for arbitrary expressions:

input = %Q(
  let x = 1 + 2
  let y = 10 / 2 + 2
  let z = 100)

puts "Parsing input:"
puts input
puts
puts "Generated AST:"
pp grammar.parse(input).result

# Additionally, we can output the grammar rules for further processing e.g.
# to generate optimized C code with.

puts
puts "Grammar rules:"
puts grammar.to_s
