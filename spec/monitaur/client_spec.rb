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