
module Rupac
  class ParserResult
    attr_reader :success
    attr_reader :result
    attr_reader :residual
    attr_reader :error

    def self.pass(result:, residual:)
      new(
        success: true,
        result: result,
        residual: residual,
        error: nil
      )
    end

    def self.fail(residual:, error:)
      new(
        success: false,
        result: nil,
        residual: residual,
        error: error
      )
    end

    def initialize(success:, result:, residual:, error:)
      @success = success
      @result = result
      @residual = residual
      @error = error
    end

    def passed?
      success
    end

    def failed?
      !passed?
    end

    def ==(other)
      success == other.success &&
        result == other.result &&
        residual == other.residual &&
        error == other.error
    end

    def to_s
      "ParserResult\n  success: #{success}\n  result: #{result}\n  residual: #{residual}\n  error:#{error}"
    end
  end
end
