require 'spec_helper'

module Monitaur
  describe Client do
    let(:client) { Monitaur::Client.new("testagentkey") }
    
    it "expects an agent key" do
      expect { c = Monitaur::Client.new }.to raise_error(ArgumentError)
    end    
  end
end