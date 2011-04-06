require 'spec_helper'

describe Monitaur do
  before do
    ENV['HOME'] = "/home/user"
  end
  
  describe '.run' do
    let(:config_file) { mock('config_file') }
    
    before do
    end

    it "creates the required application files" do
      FileUtils.should_receive(:mkdir_p).with(Monitaur.base_dir)
      FileUtils.should_receive(:touch).with(Monitaur.log_file_path)
      FileUtils.should_receive(:mkdir_p).with(Monitaur.cache_dir)
      FileUtils.should_receive(:mkdir_p).with(Monitaur.plugin_dir)
      FileUtils.should_receive(:mkdir_p).with(Monitaur.config_dir)
      
      File.should_receive(:open).
        with(Monitaur.config_file_path, "w").
        and_yield(config_file)
      config_file.should_receive(:puts).
        with('server_url: http://api.monitaurapp.com')
      config_file.should_receive(:puts).
        with('client_key: CHANGEME')
      Monitaur.install
    end
  end

  context "logging" do
    describe '.log_file_path' do
      it "returns '/home/user/.monitaur/client.log'" do
        Monitaur.log_file_path.should == "/home/user/.monitaur/client.log"
      end
    end
    
    describe '.log_file_path=' do
      it "sets @log_file_path" do
        Monitaur.log_file_path = "/tmp/something.log"
        Monitaur.log_file_path.should == "/tmp/something.log"
      end
    end
    
    describe '.log' do
      it "functions as a logger" do
        Monitaur.log.should be_an_instance_of(Logger)
        lambda { Monitaur.log.info "TEST" }.should_not raise_error
      end
    end
  end
  
  context "environment" do
    describe '.env=' do
      it "sets the @env variable" do
        Monitaur.env = "pants"
        Monitaur.env.should == "pants"
      end
    end

    describe '.env' do
      it "returns 'test' inside specs" do
        Monitaur.env.should == "test"
      end
    end
  end
end