require 'spec_helper'

module Monitaur
  describe Client do
    let(:server_url) { "http://api.monitaurapp.com" }
    let(:client_key) { "asdf1234" }
    
    describe "#load_config" do
      let(:client) { Monitaur::Client.new }
      
      before do
        File.open(Monitaur.config_file_path, "w") do |file|
          file.puts "server_url: http://api.monitaurapp.com"
          file.puts "client_key: asdf1234"
        end 
      end
     
      it "loads up the configuration file" do
        client.load_config
        client.server_url.should == "http://api.monitaurapp.com"
        client.client_key.should == "asdf1234"
      end
    end
    
    describe "#get_plugin_manifest" do
      let(:client) { Monitaur::Client.new }
      
      before do
        stub_get_plugin_manifest
      end
      
      it "retrieves a plugins manifest from the server" do
        client.get_plugin_manifest
        client.plugin_manifest.should == plugin_manifest_response
      end
    end
    
    describe "#sync_plugins" do
      let(:client) { Monitaur::Client.new }

      before do
        Monitaur.install
        stub_get_plugin_manifest
        stub_sync_plugins
        client.get_plugin_manifest
      end
      
      it "downloads plugins to the cache directory" do
        client.sync_plugins
        File.exist?(File.join(Monitaur.plugin_dir, "foo_plugin.rb")).should be_true
        File.exist?(File.join(Monitaur.plugin_dir, "bar_plugin.rb")).should be_true
        File.open(File.join(Monitaur.plugin_dir, "bar_plugin.rb")).read.should include("class BarPlugin")

      end
    end
  end
end

def stub_get_plugin_manifest
  stub_request(:get, "#{server_url}/nodes/#{client_key}/plugins").
    to_return(
      :status => 200,
      :body => %Q{
        [
          {
            "name": "foo_plugin",
            "checksum": "qwer5678"
          },
          {
            "name": "bar_plugin",
            "checksum": "hjkl4321"
          }
        ]
      }
    )
end

def plugin_manifest_response
  [
    {
      "name" => "foo_plugin",
      "checksum" => "qwer5678"
    },
    {
      "name" => "bar_plugin",
      "checksum" => "hjkl4321"
    }
  ]
end

def stub_sync_plugins
  stub_request(:get, "#{server_url}/plugins/foo_plugin").
    to_return(:body => stub_foo_plugin)
  
  stub_request(:get, "#{server_url}/plugins/bar_plugin").
    to_return(:body => stub_bar_plugin)
end

def stub_foo_plugin
  %|
  class FooPlugin < Monitaur::Plugin
    name "foo_plugin"
    desc "A test plugin to determine whether plugin sync works"

    def run
      { :foo => 'foo' }
    end
  end
  |
end

def stub_bar_plugin
  %|
  class BarPlugin < Monitaur::Plugin
    name "bar_plugin"
    desc "A test plugin to determine whether plugin sync works"

    def run
      { :bar => 'bar' }
    end
  end
  |
end