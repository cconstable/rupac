require 'rupac'

module Rupac
  module GrammarParser
    def self.create
      grammar_parser = Grammar.new do
        rule(:combinator_name)  { many1(alphanumeric | any('_-')) }
        rule(:empty_value)      { lookahead(match(')')) }
        rule(:combinator_value) { rule(:empty_value) | quoted_string | rule(:rule) < (match(',') >> rule(:combinator_value)) }
        rule(:rule)             { rule(:combinator_name) >> match('(') >> rule(:combinator_value) >> match(')') }
        rule(:grammar)          { rule(:rule) }
        rule(:grammar)
      end

      grammar_parser.process_rules do
        process(:combinator_name) do |v|
          v.flatten.join
        end

        process(:combinator_value) do |v|
          v.reject { |v| v.nil? }
        end

        process(:rule) do |v|
          {
            name: v[0][0][0],
            input: v[0][1].flatten.reject { |v| v == ',' }
          }
        end
      end

      grammar_parser
    end
  end
end
