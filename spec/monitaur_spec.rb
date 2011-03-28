require 'spec_helper'

describe Monitaur do

  describe '.run' do
    let(:config_file) { mock('config_file') }
      
    before do
      FileUtils.stub(:mkdir_p).and_return(true)
      FileUtils.stub(:touch).and_return(true)
      File.stub(:open).with(Monitaur.config_file_path, "w").and_yield(config_file)
      IO.stub(:read).and_return(config_file)
    end

    it "creates the required application files" do
      # FileUtils.stub(:mkdir_p).and_return(true)
      # FileUtils.stub(:touch).and_return(true)
      FileUtils.should_receive(:mkdir_p).with("/var/cache/monitaur")
      FileUtils.should_receive(:mkdir_p).with("/var/log")
      FileUtils.should_receive(:touch).with("/var/log/monitaur.log")
      FileUtils.should_receive(:mkdir_p).with("/etc/monitaur")
      
      File.should_receive(:open).with(Monitaur.config_file_path, "w").
        and_yield(config_file)
      config_file.should_receive(:puts).with('server_url "http://api.monitaurapp.com"')
      config_file.should_receive(:puts).with('client_key "CHANGEME"')
      Monitaur.install
    end
  end

  context "logging" do
    describe '.log_file_path' do
      it "returns '/var/log/monitaur.log" do
        Monitaur.log_file_path.should == "/var/log/monitaur.log"
      end
    end
    
    describe '.log_file_path=' do
      before do
        Monitaur.log_file_path = "/tmp/something.log"
      end
      it "sets @log_file_path" do
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
    describe '.default_env' do
      it "returns 'production'" do
        Monitaur.default_env.should == "production"
      end

      it "is not settable" do
        expect { Monitaur.default_env = "pants" }.to raise_error 
      end
    end

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