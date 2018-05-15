[![GitHub release](https://img.shields.io/github/release/cconstable/rupac.svg)](https://github.com/cconstable/rupac/releases/latest)
[![Build Status](https://travis-ci.org/cconstable/rupac.svg?branch=master)](https://travis-ci.org/cconstable/rupac)
[![Coverage Status](https://coveralls.io/repos/github/cconstable/rupac/badge.svg)](https://coveralls.io/github/cconstable/rupac)

# Rupac

A monadic parser combinator library for Ruby capable of parsing complex recursive grammars.

```ruby
# A simple recursive grammar for tuples
grammar = Grammar.new do
  rule(:value) { quoted_string | number | rule(:tuple) }
  rule(:tuple) { match('(') >> rule(:value) >> match(',') >> rule(:value) >> match(')') }

  rule(:tuple)
end

puts grammar.parse("(1,(2,3))") # => pass
puts grammar.parse("((1,2)")    # => fail
```

## Installation

TODO

## Why?

Monadic parser combinators allow us to generate lexers (something that tokenizes input) and parsers (something that transforms input into something meaningful) by describing grammars in a way that is structurally similar to the [BNF](https://en.wikipedia.org/wiki/Backus%E2%80%93Naur_form) form of the grammars themselves. Practically, this means we can write a [JSON parser in only a few lines of code](https://github.com/cconstable/rupac/blob/master/examples/json.rb) that is easy to understand and maintain.

## Usage

A `Grammar` defines something you want to parse. Grammars are constructed by creating one or more rules. The "root" rule for the grammar is returned as the last item in the block. The root rule should contain all the other rules.

```ruby
require 'rupac'
grammar = Grammar.new do
  rule(:the_number_one) { match('1') }
  rule(:the_number_one) # root rule
end
```

Rules are made from parsers:

```ruby
match('abc')  # matches the string "abc"
number        # matches numbers like "1234"
whitespace    # matches whitespace
...
```

Parsers can be combined using *combinators* to form new parsers. By combining the base parsers you can create the building blocks for parsing more complex strings.

```ruby
match('hello') >> match('!')   # matches "hello" and then "!"
match('good') > match('night') # optionally matches "good" and always matches "night"
many1(alphanumeric)            # matches a string of alphanumeric characters
...
```

Once a grammar has been specified, additional processing rules can be defined to *transform* the input. For example, you may wish to convert a string into a number or a CSV row into a Ruby array.

```ruby
grammar.process_rules do
  process(:the_number_one) { |v| v.to_i }
end
```

Parsing is done via the `parse` method of the grammar. Parsing returns an algebraic data type, `ParserResult` , that represents either a success or failure. If successful, it will contain the result (what was parsed) and the residual (the remainder of the input). If unsuccessful, it will return the input as the residual.

```ruby
r = grammar.parse('123')
puts r.passed?  # => true
puts r.result   # => 1
puts r.residual # => 23

r = grammar.parse('321')
puts r.failed?  # => true
puts r.residual # => 321
```

### Parsers

- `alphanumeric`: parses an alphanumeric character.
- `any_except(string)`: parses any character except the characters in the provided string.
- `any(string)`: parses any character in the provided string.
- `digit`: parses a digit.
- `eof`: excepts only whitespace in the remaining input.
- `fail`: always fails and returns the input as the residual.
- `match(string)`: matches the provided string.
- `number`: parses a number.
- `quoted_string`: parses anything between "".
- `success`: always succeeds.
- `whitespace`: consumes all whitespace.
- `whitespace(string)`: consumes all whitespace around the provided string.

### Combinators

- `parser1 | parser2`: "chooses" parser1 if it succeeds, otherwise, parser2.
- `lookahead(parser)`: runs the provided parser without consuming input.
- `many0(parser)`: attempts to run the parser zero or more times.
- `many1(parser)`: expects one or more successful parser runs.
- `parser1 > parser2`: optionally tries parser1 and always runs parser2.
- `parser1 < parser2`: always runs parser1 and optionally tries parser2.
- `parser1 >> parser2`: runs parser1 and then parser2.

### Utility

- `parser.map { }`: transforms parser results on success.
- `parser.flat_map { }`: transforms parser results on success. Monadic bind.
- `parser.pure(value)`: lifts a value into the parser. The parser will always return this value.
- `parser.apply(value)`: applies a value to the function contained by the parser.
- `parser.name(string)`: returns a new parser that will use the provided name for debugging and printing.
- `parser.error(string)`: returns a new parser that will use the provided error for debugging.

## Examples

See `/examples`:

- [applicative](https://github.com/cconstable/rupac/blob/master/examples/applicative.rb)
- [expressions](https://github.com/cconstable/rupac/blob/master/examples/expressions.rb)
- [functor](https://github.com/cconstable/rupac/blob/master/examples/functor.rb)
- [json](https://github.com/cconstable/rupac/blob/master/examples/json.rb)
- [monad](https://github.com/cconstable/rupac/blob/master/examples/monad.rb)
- [recursive_grammar](https://github.com/cconstable/rupac/blob/master/examples/recursive_grammar.rb)
- [yaml](https://github.com/cconstable/rupac/blob/master/examples/yaml.rb)

## Development

- Setup: `bin/setup`
- Console: `bin/console`

## Tests

- `rake spec`

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
