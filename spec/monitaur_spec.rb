require 'spec_helper'

describe Overwatch do
  before do
    ENV['HOME'] = "/home/user"
  end
  
  describe '.run' do
    let(:config_file) { mock('config_file') }
    
    before do
    end

    it "creates the required application files" do
      FileUtils.should_receive(:mkdir_p).with(Overwatch.base_dir)
      FileUtils.should_receive(:touch).with(Overwatch.log_file_path)
      FileUtils.should_receive(:mkdir_p).with(Overwatch.cache_dir)
      FileUtils.should_receive(:mkdir_p).with(Overwatch.plugin_dir)
      FileUtils.should_receive(:mkdir_p).with(Overwatch.config_dir)
      
      File.should_receive(:open).
        with(Overwatch.config_file_path, "w").
        and_yield(config_file)
      config_file.should_receive(:puts).
        with('server_url: http://api.overwatchapp.com')
      config_file.should_receive(:puts).
        with('client_key: CHANGEME')
      Overwatch.install
    end
  end

  context "logging" do
    describe '.log_file_path' do
      it "returns '/home/user/.overwatch/client.log'" do
        Overwatch.log_file_path.should == "/home/user/.overwatch/client.log"
      end
    end
    
    describe '.log_file_path=' do
      it "sets @log_file_path" do
        Overwatch.log_file_path = "/tmp/something.log"
        Overwatch.log_file_path.should == "/tmp/something.log"
      end
    end
    
    describe '.log' do
      it "functions as a logger" do
        Overwatch.log.should be_an_instance_of(Logger)
        lambda { Overwatch.log.info "TEST" }.should_not raise_error
      end
    end
  end
  
  context "environment" do
    describe '.env=' do
      it "sets the @env variable" do
        Overwatch.env = "pants"
        Overwatch.env.should == "pants"
      end
    end

    describe '.env' do
      it "returns 'test' inside specs" do
        Overwatch.env.should == "test"
      end
    end
  end
end