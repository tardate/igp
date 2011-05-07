require 'spec_helper'
require 'getoptions'

describe Igp::Base::Format do

  describe '#duration' do
    it "should return nil for nil duration" do
      subject.duration(nil).should be_nil
    end
    it "should return string to 6 decimal places for non-nil duration" do
      result = subject.duration(1.0)
      result.should match(/^\d+\.\d{6}$/)
      result.to_f.should eql(1.0)
    end
    it "should handle integer parameter" do
      result = subject.duration(1)
      result.should match(/^\d+\.\d{6}$/)
      result.to_f.should eql(1.0)
    end
  end

  describe '#header' do
    it "should output a blank line for nil parameters" do
      result = capture(:stderr){ subject.header(nil) }
      result.should eql("\n")
    end
    it "should convert an arbitrary array of strings and numbers to a space-delimited output to stderr" do
      result = capture(:stderr){ subject.header("string",1.0,"another string",2.0) }
      result.should eql("string 1.0 another string 2.0\n")
    end
  end

  describe '#log' do
    it "should output time only for nil parameters" do
      result = capture(:stdout){ subject.log(nil) }
      result.should match(/^.+Z,$/)
    end
    it "should log successful message (boolean,float,nil) to stdout" do
      result = capture(:stdout){ subject.log(true,1.0,nil) }
      result.should match(/^.+Z,true,1.0,$/)
    end
    it "should log unsuccessful message (boolean,nil,string) to stdout" do
      result = capture(:stdout){ subject.log(false,nil,"message") }
      result.should match(/^.+Z,false,,message$/)
    end
  end

end