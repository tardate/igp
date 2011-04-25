require 'spec_helper'
require 'getoptions'

describe Igp::Shell do

  describe "base configuration" do
    context 'without destination specified' do
      before do
        @options = GetOptions.new(Igp::Shell::OPTIONS, [])
      end
      it "should initialize without error" do
        expect { Igp::Shell.new(@options,[]) }.to_not raise_error
      end
      it "should provide help/usage" do
        Igp::Shell.respond_to?(:usage).should be_true
        Igp::Shell.new(@options,[]).respond_to?(:usage).should be_true
      end
      it "should print usage when run" do
        shell = Igp::Shell.new(@options,[])
        shell.should_receive(:usage)
        shell.run
      end
    end
    context 'with destination specified' do
      before do
        @options_server_value = 'example.com'
        @options = GetOptions.new(Igp::Shell::OPTIONS, [])
        @shell = Igp::Shell.new(@options,[@options_server_value])
      end
      it "should default to 1 second infinte intervals" do
        @shell.options[:interval].should eql(1)
        @shell.options[:limit].should be_nil
      end
      it "should accept server and default to icmp ping" do
        @shell.options[:host].should eql(@options_server_value)
        @shell.options[:type].should eql(:icmp)
      end
    end
  end
  
  describe "tcp configuration" do
    before(:each) do
      @type = :tcp
      @host = 'localhost'
      @port = 843
      @options_server_value = "#{@type.to_s}://#{@host}:#{@port}"
      @shell = Igp::Shell.new(GetOptions.new(Igp::Shell::OPTIONS, []), [@options_server_value])
    end
    it "should support url accessor" do
      @shell.options[:url].should eql(@options_server_value)
    end
    it "should default to tcp ping with url when given server with tcp protocol setting" do
      @shell.options[:type].should eql(@type)
    end
    it "should resolve host/port" do
      @shell.options[:host].should eql(@host)
      @shell.options[:port].should eql(@port)
    end
  end

  describe "udp configuration" do
    before(:each) do
      @type = :udp
      @host = 'localhost'
      @port = 22
      @options_server_value = "#{@type.to_s}://#{@host}:#{@port}"
      @shell = Igp::Shell.new(GetOptions.new(Igp::Shell::OPTIONS, []), [@options_server_value])
    end
    it "should support url accessor" do
      @shell.options[:url].should eql(@options_server_value)
    end
    it "should default to tcp ping with url when given server with tcp protocol setting" do
      @shell.options[:type].should eql(@type)
    end
    it "should resolve host/port" do
      @shell.options[:host].should eql(@host)
      @shell.options[:port].should eql(@port)
    end
  end

  describe "http configuration" do
    before(:each) do
      @type = :http
      @host = 'localhost'
      @port = 80
      @options_server_value = "#{@type.to_s}://#{@host}"
      @shell = Igp::Shell.new(GetOptions.new(Igp::Shell::OPTIONS, []), [@options_server_value])
    end
    it "should support url accessor" do
      @shell.options[:url].should eql(@options_server_value)
    end
    it "should default to tcp ping with url when given server with tcp protocol setting" do
      @shell.options[:type].should eql(@type)
    end
    it "should resolve host/port" do
      @shell.options[:host].should eql(@host)
      @shell.options[:port].should eql(@port)
    end
  end

  describe "https configuration" do
    before(:each) do
      @type = :https
      @host = 'localhost'
      @port = 443
      @options_server_value = "#{@type.to_s}://#{@host}"
      @shell = Igp::Shell.new(GetOptions.new(Igp::Shell::OPTIONS, []), [@options_server_value])
    end
    it "should support url accessor" do
      @shell.options[:url].should eql(@options_server_value)
    end
    it "should default to tcp ping with url when given server with tcp protocol setting" do
      @shell.options[:type].should eql(@type)
    end
    it "should resolve host/port" do
      @shell.options[:host].should eql(@host)
      @shell.options[:port].should eql(@port)
    end
  end

  describe "ldap configuration" do
    before(:each) do
      @type = :ldap
      @host = 'localhost'
      @port = 389
      @options_server_value = "#{@type.to_s}://#{@host}"
      @shell = Igp::Shell.new(GetOptions.new(Igp::Shell::OPTIONS, []), [@options_server_value])
    end
    it "should support url accessor" do
      @shell.options[:url].should eql(@options_server_value)
    end
    it "should default to tcp ping with url when given server with tcp protocol setting" do
      @shell.options[:type].should eql(@type)
    end
    it "should resolve host/port" do
      @shell.options[:host].should eql(@host)
      @shell.options[:port].should eql(@port)
    end
  end

  describe "ldaps configuration" do
    before(:each) do
      @type = :ldaps
      @host = 'localhost'
      @port = 636
      @options_server_value = "#{@type.to_s}://#{@host}"
      @shell = Igp::Shell.new(GetOptions.new(Igp::Shell::OPTIONS, []), [@options_server_value])
    end
    it "should support url accessor" do
      @shell.options[:url].should eql(@options_server_value)
    end
    it "should default to tcp ping with url when given server with tcp protocol setting" do
      @shell.options[:type].should eql(@type)
    end
    it "should resolve host/port" do
      @shell.options[:host].should eql(@host)
      @shell.options[:port].should eql(@port)
    end
  end

end