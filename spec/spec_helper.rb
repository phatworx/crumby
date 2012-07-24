$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'bundler/setup'
Bundler.require

require 'rspec'
require 'crumby'

if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start
  # For rails applications use
  # SimpleCov.start 'rails'
end

#require 'crumby'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|

end
