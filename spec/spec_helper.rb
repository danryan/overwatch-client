require 'rubygems'
require 'spork'

Spork.prefork do
  $LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
  $LOAD_PATH.unshift(File.dirname(__FILE__))
  require 'rspec'
  require 'fakefs/safe'
  # require 'rest-client'
  # require 'monitaur'

  # Requires supporting files with custom matchers and macros, etc,
  # in ./support/ and its subdirectories.
  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

  
  RSpec.configure do |config|
    config.before do
      FakeFS.activate!
    end
    config.after do
      FakeFS.deactivate!
    end
  end
end

Spork.each_run do
  require 'monitaur'
  RSpec.configure do |config|
    config.before do
      Monitaur.env = "test"
    end
  end
end
