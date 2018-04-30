require 'parser'
require 'parsers'

class Grammar
  class RuleBuilder
    include Rupac::Combinators
    include Rupac::Parsers

    attr_reader :rules
    def initialize
      @rules = {}
    end

    def rule(key)
      desc = Rupac::ParserDescriptor.new("rule(\"#{key}\")")
      Rupac::Parser.new(desc) do |input|
        rules[key.to_sym].parse(input)
      end
    end

    def create_rule(key, &block)
      rules[key.to_sym] = instance_eval &block
    end

  end

  attr_reader :rule_builder
  attr_reader :root_parser

  def initialize(&block)
    @rule_builder = RuleBuilder.new
    @root_parser = instance_eval &block
  end

  def to_s
    rule_builder.rules
      .map { |k, v| "#{k}: #{v.to_s}" }
      .join("\n")
  end

  def rule(key, &block)
    if block_given?
      rule_builder.create_rule(key, &block)
    else
      rule_builder.rules[key.to_sym]
    end
  end

  def process_rules(&block)
    instance_eval &block
  end

  def process(key, &block)
    parser = rule_builder.rules.fetch(key.to_sym)
    rule_builder.rules[key.to_sym] = parser.map(&block)
  end

  def parse(input)
    root_parser.parse(input)
  end
end
