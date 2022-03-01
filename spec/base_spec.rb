require 'spec_helper'
require 'getoptions'

describe Igp::Base do
  describe 'base initialization without options' do
    it 'should not set ping_handler' do
      expect(subject.ping_handler).to be_nil
    end
    it 'should not set limit' do
      expect(subject.limit).to be_nil
    end
    it 'should default interval to 5 sec' do
      expect(subject.interval).to eql(5)
    end
  end

  describe 'ping_handler configuration' do
    it 'should be Net::Ping::External for :icmp' do
      options = { type: :icmp, host: 'localhost', port: nil }
      base = Igp::Base.new(options)
      expect(base.ping_handler).to be_a(Net::Ping::External)
    end
    it 'should be Net::Ping::UDP for :tcp' do
      options = { type: :udp, host: 'localhost', port: 22 }
      base = Igp::Base.new(options)
      expect(base.ping_handler).to be_a(Net::Ping::UDP)
    end
    it 'should be Net::Ping::TCP for :tcp' do
      options = { type: :tcp, host: 'localhost', port: 22 }
      base = Igp::Base.new(options)
      expect(base.ping_handler).to be_a(Net::Ping::TCP)
    end
    it 'should be Net::Ping::HTTP for :http' do
      options = { type: :http, url: 'http://localhost' }
      base = Igp::Base.new(options)
      expect(base.ping_handler).to be_a(Net::Ping::HTTP)
    end
    it 'should be Net::Ping::HTTP for :https' do
      options = { type: :https, url: 'https://localhost' }
      base = Igp::Base.new(options)
      expect(base.ping_handler).to be_a(Net::Ping::HTTP)
    end
    it 'should be Net::Ping::LDAP for :ldap' do
      options = { type: :ldap, url: 'ldap://localhost' }
      base = Igp::Base.new(options)
      expect(base.ping_handler).to be_a(Net::Ping::LDAP)
    end
    it 'should be Net::Ping::LDAP for :ldaps' do
      options = { type: :ldaps, url: 'ldaps://localhost' }
      base = Igp::Base.new(options)
      expect(base.ping_handler).to be_a(Net::Ping::LDAP)
    end
  end

  describe '#run' do
    before do
      @good = Igp::Base.new({ type: :icmp, host: 'localhost', port: nil, limit: 1 })
    end
    it 'should print header and log a ping result' do
      expect(@good.formatter).to receive(:header)
      expect(@good.formatter).to receive(:log)
      capture(:stdout, :stderr) { @good.run }
    end
  end
end
