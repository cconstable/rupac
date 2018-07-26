#!/usr/bin/env ruby

require 'bundler/setup'
require 'rupac'

# The JSON grammar can be expressed 11 rules that reflect the natural
# structure of the specification:

grammar = Grammar.new do
  rule(:true)           { match('true') }
  rule(:false)          { match('false') }
  rule(:null)           { match('null') }
  rule(:key)            { quoted_string }
  rule(:value)          { quoted_string | number | rule(:true) | rule(:false) | rule(:null) | rule(:json) }
  rule(:pair)           { rule(:key) >> whitespace(':') >> rule(:value) }
  rule(:hash_member)    { rule(:pair) < (whitespace(',') >> rule(:hash_member)) }
  rule(:hash)           { (whitespace('{') < rule(:hash_member)) >> whitespace('}') }
  rule(:array_element)  { rule(:value) < (whitespace(',') >> rule(:array_element)) }
  rule(:array)          { (whitespace('[') < rule(:array_element)) >> whitespace(']') }
  rule(:json)           { rule(:hash) | rule(:array) }

  rule(:json)
end

puts grammar.to_s









# At this point we have a grammar that can be used to validate JSON. However,
# the parser will simply return the raw ParserResult. If we want the parser to
# return more useful Ruby objects (e.g. hashes and arrays) we can add some
# processing rules:

grammar.process_rules do
  process(:true)            { |_| true }
  process(:false)           { |_| false }
  process(:null)            { |_| "nil" }
  process(:key)             { |v| v.to_sym }
  process(:pair)            { |v| {v[0][0] => v[1]} }
  process(:hash_member)     { |v| v.flatten.reject(&:nil?).reject { |v| v == "," }.reduce({}, &:merge) }
  process(:hash)            { |v| v.flatten[1..-2][0] }
  process(:array_element)   { |v| [v].flatten(3).reject(&:nil?).reject { |v| v == "," }}
  process(:array)           { |v| v[0][1] }
end

# ----------------------------------------------------------------------------
# Examples

valid_json = [
  %Q(
    {
      "number": 1,
      "string": "value",
      "hash": {
        "a": true,
        "b": false
      },
      "array": [1, 2, 3]
    }
  ),
  %Q(
    [1,2,{"a":3,"b":true}]
  ),
  %Q(
    {
      "string": "value",
      "hash": {
        "nested_hash": {
          "x": [1, 2],
          "y": 2,
          "z": [10, 20, 30, null]
        },
        "b": true
      },
      "nested_arrays": [[1, [[7,7,7], 9], 3], [4, 5], 6]
    }
  )
]

invalid_json = [
  %Q(
    {
      "number": 1,
      "string": "value",
      "hash"= {
        "a": 1,
        "b": 2
      },
      "array": [1, 2, 3]
    }
  ),
  %Q(
    [1,2,,{"a":3,"b":4}]
  ),
  %Q(
    {
      "string": "value",
      "hash": {
        "nested_hash"
    }
  )
]

puts
puts "------------------------------------------"
puts "Valid JSON"
puts
valid_json.each   { |j| puts grammar.parse(j) }

puts
puts "------------------------------------------"
puts "Invalid JSON"
puts
invalid_json.each { |j| puts grammar.parse(j) }
