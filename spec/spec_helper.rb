require 'rubygems'
require 'spork'

Spork.prefork do
  $LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
  $LOAD_PATH.unshift(File.dirname(__FILE__))
  require 'bundler'
  
  Bundler.setup(:development)
  require 'rspec'
  require 'tempfile'
  
  RSpec.configure do |config|

  end
end

Spork.each_run do
  require 'monitaur'
  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
  
  RSpec.configure do |config|
    config.before do
      Monitaur.env = "test"
    end
  end
end