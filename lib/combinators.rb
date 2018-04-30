Dir["lib/combinators/*.rb"].each { |f| require File.expand_path(f) }

module Rupac
  module Combinators
    extend self
  end
end
