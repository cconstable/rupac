require 'rupac'

module Rupac
  class ParserDescriptor
    attr_reader :name

    def self.parser(name: "", input: [])
      input = input
        .map { |e| e.is_a?(String) ? e.gsub(/"/, "\\\"") : e }
        .map { |e| "\"#{e}\"" }
        .join(',')
      ParserDescriptor.new("#{name}(#{input})")
    end

    def self.combinator(name: "", input: [])
      input = input
        .map { |e| e.to_s }
        .join(',')
      ParserDescriptor.new("#{name}(#{input})")
    end

    def initialize(name = "")
      @name = name
    end

    def to_s
      name
    end
  end
end
