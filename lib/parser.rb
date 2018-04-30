require 'parser_descriptor'
require 'parser_result'
require 'combinators'
require 'exceptions/invalid_parser_input'

module Rupac
  class Parser
    include Rupac::Combinators

    attr_reader :descriptor
    attr_reader :block

    def self.pure(value = nil, &fn)
      if !value.nil? && ((value.class.name.eql? "Method") || (value.class.name.eql? "Proc"))
        value = value.curry
      elsif !fn.nil?
        value = fn.curry
      end

      descriptor = ParserDescriptor.parser(
        name: "pure",
        input: [value].flatten
      )
      Parser.new(descriptor) do |input|
        ParserResult.pass(
          result: value,
          residual: input
        )
      end
    end

    def initialize(descriptor = ParserDescriptor.new, &block)
      @descriptor = descriptor
      @block = block
    end

    def parse(input)
      return block.call(input)
    end

    def to_s
      descriptor.name || super
    end

    # convenience map
    def map(&block)
      fmap do |r|
        ParserResult.pass(
          result: block.call(r.result),
          residual: r.residual
        )
      end
    end

    # the true functor map
    def fmap(&block)
      Parser.new(descriptor) do |input|
        result = parse(input)
        if result.passed?
          block.(result)
        else
          result
        end
      end
    end

    def apply(parser)
      parser.fmap do |r|
        ParserResult.pass(
          result: parse(r.residual).result.(r.result),
          residual: r.residual
        )
      end
    end
    alias_method :*, :apply

    def flat_map(fn = nil, &block)
      block = fn unless fn.nil?
      fmap { |r| block.(r.result).parse(r.residual) }
    end
    alias_method :>=, :flat_map

  end
end
