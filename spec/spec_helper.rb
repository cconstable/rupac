require 'bundler/setup'
require 'simplecov'
SimpleCov.start { add_filter "/spec/" }

require 'rupac'
$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')

Dir["spec/support/**/*.rb"].each { |f| require File.expand_path(f) }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
