module Rupac
  class ParserMapRequiresBlock < StandardError
    def initialize(input)
      super("Invoking map on a Parser requires a block as input. Received: #{input}")
    end
  end
end
