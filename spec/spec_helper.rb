require 'rubygems'
require 'spork'

Spork.prefork do 
  ENV["RACK_ENV"] ||= 'test'
  require 'rspec'

  support_files = File.join(File.expand_path(File.dirname(__FILE__)), "spec/support/**/*.rb")
  Dir[support_files].each {|f| require f}

  ENV['REDIS_URL'] = 'redis://localhost:6379/3'

  RSpec.configure do |config|
    config.color_enabled = true
    config.formatter = "documentation"
    config.mock_with :rspec
    
    config.before :suite do
      $redis.flushdb
    end
  end
end

Spork.each_run do
end