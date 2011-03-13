require 'spec_helper'

describe Monitaur do
  describe '.run' do
      
    it "should accept a node key" do
      lambda { Monitaur.run("asdfasdf") }.should_not raise_error
      Monitaur.agent_key.should == "asdfasdf"
    end
    
    context "first run" do
      before do
        Monitaur.stub(:first_run?).and_return(true)
        Monitaur.run("asdfasdf")
      end
      
      it "creates the log file" do
        File.exist?("/var/log/monitaur.log").should == true
      end
      
      it "creates the cache directory" do
        File.exist?("/var/cache/monitaur").should == true
      end
    end
  end
  
  describe '.first_run?' do
    it "returns true if /var/log/monitaur.log does not exist" do
      FileUtils.rm("/var/log/monitaur.log") if File.exist?("/var/log/monitaur.log")
      Monitaur.first_run?.should == true
    end
    
    it "returns true if /var/cache/monitaur/ does not exist" do
      FileUtils.rmdir("/var/cache/monitaur") if File.exist?("/var/cache/monitaur")
      Monitaur.first_run?.should == true
    end
    it "returns false if all the necessary files exist" do
      FileUtils.mkdir_p("/var/log/")
      FileUtils.mkdir_p("/var/cache/monitaur")
      FileUtils.touch("/var/log/monitaur.log")
      Monitaur.first_run?.should == false
    end
  end
  
  context "logging" do
    describe '.default_log_file_path' do
      it "is not settable" do
        expect { Monitaur.default_log_file_path = "/tmp/monitaur.log" }.to
          raise_error
      end
    
      it "returns '/var/log/monitaur.log" do
        Monitaur.default_log_file_path.should == "/var/log/monitaur.log"
      end
    end
  
    describe '.log_file_path' do
      it "returns '/var/log/monitaur.log" do
        Monitaur.log_file_path.should == "/var/log/monitaur.log"
      end
    end
    
    describe '.log_file_path=' do
      it "sets @log_file_path" do
        Monitaur.log_file_path = "/tmp/something.log"
        Monitaur.log_file_path.should == "/tmp/something.log"
      end
    end
    
    describe '.log' do
      it "is an instance of Logger" do
        Monitaur.log.should be_an_instance_of(Logger)
      end
      it "is writable" do
        lambda { Monitaur.log.info "TEST" }.should_not raise_error
      end
    end
  end
  

  describe '.create_log_file' do
    it "creates /var/log/monitaur.log" do
      Monitaur.create_log_file
      File.exist?("/var/log/monitaur.log").should == true
    end
    it "does not raise an error" do
      lambda { Monitaur.create_log_file }.should_not raise_error
    end
  end
  
  describe '.create_cache_directory' do
    it "creates /var/cache/monitaur/" do
      Monitaur.create_cache_directory
      File.exist?("/var/cache/monitaur").should == true
    end
    it "does not raise an error" do
      lambda { Monitaur.create_cache_directory }.should_not raise_error
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

      it "can be set" do
        Monitaur.env = "pants"
        Monitaur.env.should == "pants"
      end
    end
  end
end
