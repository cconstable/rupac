Dir["lib/parsers/*.rb"].each { |f| require File.expand_path(f) }

module Rupac
  module Parsers
    extend self
  end
end
