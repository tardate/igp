require 'spec_helper'
require 'fakeldap'

describe Net::Ping::LDAP do
  before :all do
    @ldap_server = FakeLDAP::Server.new(port: 2389)
    @ldap_server.run_tcpserver
    @ldap_server.add_user('cn=el.Daper,ou=USERS,dc=example,dc=com', 'ldappassword')
  end

  after :all do
    @ldap_server.stop
  end

  context 'when valid ldap url' do
    let(:timeout) { 30 }
    let(:cn) { 'el.Daper' }
    let(:password) { 'ldappassword' }
    let(:uri) { 'ldap://localhost:2389' }
    subject(:ldap) do
      ldap = Net::Ping::LDAP.new(uri, timeout)
      ldap.username = cn
      ldap.password = password
      ldap
    end

    describe '#ping' do
      subject { ldap.ping }
      it 'ping basic functionality' do
        expect { subject }.to_not raise_error
        expect(subject).to eql(true)
      end
    end
    describe '#ping?' do
      subject { ldap.ping? }
      it 'returns a boolean' do
        expect(subject).to eql(true)
      end
    end
    describe '#pingecho' do
      subject { ldap.pingecho }
      it 'returns a boolean' do
        expect(subject).to eql(true)
      end
    end
    describe '#duration' do
      subject { ldap.duration }
      before  { ldap.ping }
      it 'returns a float' do
        expect(subject).to be_a(Float)
      end
    end
  end

  context 'when bad ldap url' do
    let(:uri) { 'ldap://blabfoobarurghxxxx.com' }
    subject(:ldap) { Net::Ping::LDAP.new(uri) }
    describe '#ping' do
      subject { ldap.ping }
      it 'ping basic functionality' do
        expect { subject }.to_not raise_error
        expect(subject).to eql(false)
      end
    end
    describe '#ping?' do
      subject { ldap.ping? }
      it 'returns a boolean' do
        expect(subject).to eql(false)
      end
    end
    describe '#pingecho' do
      subject { ldap.pingecho }
      it 'returns a boolean' do
        expect(subject).to eql(false)
      end
    end
    describe '#duration' do
      subject { ldap.duration }
      before  { ldap.ping }
      it 'returns nil' do
        expect(subject).to be_nil
      end
    end
  end

  # test 'host attribute basic functionality' do
  #   assert_respond_to(@ldap, :host)
  #   assert_respond_to(@ldap, :host=)
  #   assert_equal(@@host, @ldap.host)
  # end

  # test 'port attribute basic functionality' do
  #   assert_respond_to(@ldap, :port)
  #   assert_respond_to(@ldap, :port=)
  # end

  # test 'port attribute expected value' do
  #   assert_equal(@@port, @ldap.port)
  # end

  # test 'timeout attribute basic functionality' do
  #   assert_respond_to(@ldap, :timeout)
  #   assert_respond_to(@ldap, :timeout=)
  # end

  # test 'timeout attribute expected values' do
  #   assert_equal(@@timeout, @ldap.timeout)
  #   assert_equal(5, @bad.timeout)
  # end

  # test 'exception attribute basic functionality' do
  #   assert_respond_to(@ldap, :exception)
  #   assert_nil(@ldap.exception)
  # end

  # test 'exception attribute is nil if the ping is successful' do
  #   assert_true(@ldap.ping)
  #   assert_nil(@ldap.exception)
  # end

  # test 'exception attribute is not nil if the ping is unsuccessful' do
  #   assert_false(@bad.ping)
  #   assert_not_nil(@bad.exception)
  # end

  # test 'warning attribute basic functionality' do
  #   assert_respond_to(@ldap, :warning)
  #   assert_nil(@ldap.warning)
  # end

  # test 'uri attribute basic functionality' do
  #   assert_respond_to(@ldap, :uri)
  #   assert_respond_to(@ldap, :uri=)
  # end

  # test 'username attribute basic functionality' do
  #   assert_respond_to(@ldap, :username)
  #   assert_respond_to(@ldap, :username=)
  # end

  # test 'password attribute basic functionality' do
  #   assert_respond_to(@ldap, :password)
  #   assert_respond_to(@ldap, :password=)
  # end

  # test 'encryption attribute basic functionality' do
  #   assert_respond_to(@ldap, :encryption)
  #   assert_respond_to(@ldap, :encryption=)
  # end

  # test 'encryption defaults to nil for ldap' do
  #   assert_nil(Net::Ping::LDAP.new('ldap://somehost.example.net').encryption)
  # end

  # test 'encryption defaults to simple_tls for ldaps' do
  #   assert_equal(:simple_tls, Net::Ping::LDAP.new('ldaps://somehost.example.net').encryption)
  # end

  # test 'port defaults to 389 for ldap' do
  #   assert_equal(389, Net::Ping::LDAP.new('ldap://somehost.example.net').port)
  # end

  # test 'port defaults to 636 for ldaps' do
  #   assert_equal(636, Net::Ping::LDAP.new('ldaps://somehost.example.net').port)
  # end

  # test 'port extracted from uri if provided' do
  #   assert_equal(12345, Net::Ping::LDAP.new('ldap://somehost.example.net:12345').port)
  #   assert_equal(12345, Net::Ping::LDAP.new('ldaps://somehost.example.net:12345').port)
  # end

  # test 'encryption setting is forced to symbol' do
  #   @ldap.encryption = 'simple_tls'
  #   assert_true( @ldap.encryption.is_a? Symbol )
  #   assert_true( @ldap.config[:encryption].is_a? Symbol )
  # end

  # test 'username/password set in config auth section' do
  #   @ldap.username, @ldap.password = 'fred', 'derf'
  #   assert_equal('fred', @ldap.config[:auth][:username] )
  #   assert_equal('derf', @ldap.config[:auth][:password] )
  # end

  # test 'auth method defaults to simple if username/password set' do
  #   @ldap.username, @ldap.password = 'fred', 'derf'
  #   assert_equal(:simple, @ldap.config[:auth][:method] )
  # end

  # test 'if no username/password then defaults to auth anonymous' do
  #   @ldap.username = @ldap.password = nil
  #   assert_equal({:method => :anonymous}, @ldap.config[:auth] )
  # end
end
