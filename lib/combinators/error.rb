require 'rupac'

module Rupac
  module Combinators
    def error(error)
      Parser.new(descriptor) do |input|
        result = parse(input)
        if result.passed?
          result
        else
          ParserResult.fail(
            residual: result.residual,
            error: error
          )
        end
      end
    end
  end
end
