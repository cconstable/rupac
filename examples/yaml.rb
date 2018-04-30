#!/usr/bin/env ruby

require 'bundler/setup'
require 'rupac'
require 'pp'

# A simple yaml-like format that contains key-value pairs and arrays. This
# does not parse indentation.

yaml = Grammar.new do
  rule(:key)         { whitespace > many1(alphanumeric | any('_-')) }
  rule(:value)       { quoted_string | number | rule(:array) | rule(:pair) }
  rule(:pair)        { rule(:key) >> whitespace(':') >> rule(:value) }
  rule(:array_item)  { whitespace('-') >> rule(:value) }
  rule(:array)       { many1(rule(:array_item)) }
  rule(:yaml)        { many1(rule(:pair)) }
  rule(:yaml)
end

yaml.process_rules do
  process(:key)         { |r| r.flatten.join.strip }
  process(:pair)        { |r| { (r[0][0]).to_sym => r[1] }}
  process(:array_item)  { |r| r[1] }
  process(:yaml)        { |r| r[0].reduce({}, &:merge) }
end

yaml_string = %Q{
  key1: "value"
  key2: "quoted value"
  key3: 3
  an_array:
    - 1
    - 2
    - 3
  another_array:
    - a_nested_array:
      - 1
      - 2
      - 3
}

pp yaml.parse(yaml_string).result
