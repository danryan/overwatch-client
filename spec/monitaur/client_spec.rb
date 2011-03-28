require 'spec_helper'

module Monitaur
  describe Client do
    before do
      config_file = <<CONFIG
server_url        "http://api.monitaurapp.com"
client_key        "ORE9ut278jk2Kkd2v6I33aALAPUB"
CONFIG
      IO.stub(:read).with(Monitaur.config_file_path).and_return(config_file)
      Monitaur::Client.run
    end
    # 
    let(:client) { Monitaur::Client.new }
    # 
    # describe "#run" do
    #   # Monitaur::Client.run
    # end
    
    describe "#server_url" do
      it "defaults to nil" do
        client.server_url.should be_nil
      end
      
      it "can set the server_url" do
        
      end
    end

    describe "#agent_key" do
    end
  end
end