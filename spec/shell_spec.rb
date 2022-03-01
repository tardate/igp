require 'spec_helper'
require 'getoptions'

describe Igp::Shell do
  describe 'base configuration' do
    context 'without destination specified' do
      before do
        @options = GetOptions.new(Igp::Shell::OPTIONS, [])
      end
      it 'should initialize without error' do
        expect { Igp::Shell.new(@options, []) }.to_not raise_error
      end
      it 'should provide help/usage' do
        expect(Igp::Shell).to respond_to(:usage)
        expect(Igp::Shell.new(@options, [])).to respond_to(:usage)
      end
      it 'should print usage when run' do
        shell = Igp::Shell.new(@options, [])
        expect(shell).to receive(:usage)
        shell.run
      end
    end
    context 'with destination specified' do
      before do
        @options_server_value = 'example.com'
        @options = GetOptions.new(Igp::Shell::OPTIONS, [])
        @shell = Igp::Shell.new(@options, [@options_server_value])
      end
      it 'should default to 1 second infinte intervals' do
        expect(@shell.options[:interval]).to eql(1)
        expect(@shell.options[:limit]).to be_nil
      end
      it 'should accept server and default to icmp ping' do
        expect(@shell.options[:host]).to eql(@options_server_value)
        expect(@shell.options[:type]).to eql(:icmp)
      end
    end
  end

  describe 'tcp configuration' do
    before(:each) do
      @type = :tcp
      @host = 'localhost'
      @port = 843
      @options_server_value = "#{@type}://#{@host}:#{@port}"
      @shell = Igp::Shell.new(GetOptions.new(Igp::Shell::OPTIONS, []), [@options_server_value])
    end
    it 'should support url accessor' do
      expect(@shell.options[:url]).to eql(@options_server_value)
    end
    it 'should default to tcp ping with url when given server with tcp protocol setting' do
      expect(@shell.options[:type]).to eql(@type)
    end
    it 'should resolve host/port' do
      expect(@shell.options[:host]).to eql(@host)
      expect(@shell.options[:port]).to eql(@port)
    end
  end

  describe 'udp configuration' do
    before(:each) do
      @type = :udp
      @host = 'localhost'
      @port = 22
      @options_server_value = "#{@type}://#{@host}:#{@port}"
      @shell = Igp::Shell.new(GetOptions.new(Igp::Shell::OPTIONS, []), [@options_server_value])
    end
    it 'should support url accessor' do
      expect(@shell.options[:url]).to eql(@options_server_value)
    end
    it 'should default to tcp ping with url when given server with tcp protocol setting' do
      expect(@shell.options[:type]).to eql(@type)
    end
    it 'should resolve host/port' do
      expect(@shell.options[:host]).to eql(@host)
      expect(@shell.options[:port]).to eql(@port)
    end
  end

  describe 'http configuration' do
    before(:each) do
      @type = :http
      @host = 'localhost'
      @port = 80
      @options_server_value = "#{@type}://#{@host}"
      @shell = Igp::Shell.new(GetOptions.new(Igp::Shell::OPTIONS, []), [@options_server_value])
    end
    it 'should support url accessor' do
      expect(@shell.options[:url]).to eql(@options_server_value)
    end
    it 'should default to tcp ping with url when given server with tcp protocol setting' do
      expect(@shell.options[:type]).to eql(@type)
    end
    it 'should resolve host/port' do
      expect(@shell.options[:host]).to eql(@host)
      expect(@shell.options[:port]).to eql(@port)
    end
  end

  describe 'https configuration' do
    before(:each) do
      @type = :https
      @host = 'localhost'
      @port = 443
      @options_server_value = "#{@type}://#{@host}"
      @shell = Igp::Shell.new(GetOptions.new(Igp::Shell::OPTIONS, []), [@options_server_value])
    end
    it 'should support url accessor' do
      expect(@shell.options[:url]).to eql(@options_server_value)
    end
    it 'should default to tcp ping with url when given server with tcp protocol setting' do
      expect(@shell.options[:type]).to eql(@type)
    end
    it 'should resolve host/port' do
      expect(@shell.options[:host]).to eql(@host)
      expect(@shell.options[:port]).to eql(@port)
    end
  end

  describe 'ldap configuration' do
    before(:each) do
      @type = :ldap
      @host = 'localhost'
      @port = 389
      @options_server_value = "#{@type}://#{@host}"
      @shell = Igp::Shell.new(GetOptions.new(Igp::Shell::OPTIONS, []), [@options_server_value])
    end
    it 'should support url accessor' do
      expect(@shell.options[:url]).to eql(@options_server_value)
    end
    it 'should default to tcp ping with url when given server with tcp protocol setting' do
      expect(@shell.options[:type]).to eql(@type)
    end
    it 'should resolve host/port' do
      expect(@shell.options[:host]).to eql(@host)
      expect(@shell.options[:port]).to eql(@port)
    end
  end

  describe 'ldaps configuration' do
    before(:each) do
      @type = :ldaps
      @host = 'localhost'
      @port = 636
      @options_server_value = "#{@type}://#{@host}"
      @shell = Igp::Shell.new(GetOptions.new(Igp::Shell::OPTIONS, []), [@options_server_value])
    end
    it 'should support url accessor' do
      expect(@shell.options[:url]).to eql(@options_server_value)
    end
    it 'should default to tcp ping with url when given server with tcp protocol setting' do
      expect(@shell.options[:type]).to eql(@type)
    end
    it 'should resolve host/port' do
      expect(@shell.options[:host]).to eql(@host)
      expect(@shell.options[:port]).to eql(@port)
    end
  end
end
