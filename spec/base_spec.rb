require 'spec_helper'
require 'getoptions'

describe Igp::Base do

  describe "base initialization without options" do
    before do
      @base = Igp::Base.new
    end
    it "should not set ping_handler" do
      @base.ping_handler.should be_nil
    end
    it "should not set limit" do
      @base.limit.should be_nil
    end
    it "should default interval to 5 sec" do
      @base.interval.should eql(5)
    end
  end
  
  describe "ping_handler configuration" do
    it "should be Net::Ping::External for :icmp" do
      options = { :type => :icmp, :host => 'localhost', :port => nil}
      base = Igp::Base.new(options)
      base.ping_handler.class.should eql(Net::Ping::External)
    end
    it "should be Net::Ping::UDP for :tcp" do
      options = { :type => :udp, :host => 'localhost', :port => 22}
      base = Igp::Base.new(options)
      base.ping_handler.should be_a(Net::Ping::UDP)
    end
    it "should be Net::Ping::TCP for :tcp" do
      options = { :type => :tcp, :host => 'localhost', :port => 22}
      base = Igp::Base.new(options)
      base.ping_handler.should be_a(Net::Ping::TCP)
    end
    it "should be Net::Ping::HTTP for :http" do
      options = { :type => :http, :url => 'http://localhost'}
      base = Igp::Base.new(options)
      base.ping_handler.should be_a(Net::Ping::HTTP)
    end
    it "should be Net::Ping::HTTP for :https" do
      options = { :type => :https, :url => 'https://localhost'}
      base = Igp::Base.new(options)
      base.ping_handler.should be_a(Net::Ping::HTTP)
    end
    it "should be Net::Ping::LDAP for :ldap" do
      options = { :type => :ldap, :url => 'ldap://localhost'}
      base = Igp::Base.new(options)
      base.ping_handler.should be_a(Net::Ping::LDAP)
    end
    it "should be Net::Ping::LDAP for :ldaps" do
      options = { :type => :ldaps, :url => 'ldaps://localhost'}
      base = Igp::Base.new(options)
      base.ping_handler.should be_a(Net::Ping::LDAP)
    end
  end

end