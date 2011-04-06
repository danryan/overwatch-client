require 'rubygems'
require 'spork'

Spork.prefork do
  $LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
  $LOAD_PATH.unshift(File.dirname(__FILE__))
  require 'bundler'
  
  Bundler.require
  
  require 'rspec'
  require 'fakefs/safe'
  require 'webmock/rspec'
  
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
      ENV['HOME'] = "/home/user"
      
      Monitaur.env = "test"
    end
  end
end