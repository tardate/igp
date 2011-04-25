class Igp::Base
  attr_reader :options
  attr_reader :ping_handler
  attr_reader :limit, :interval

  # expects a configuration hash as +options+
  # +options+ may contain:
  #  :type => symbol indicating protocol to use (:icmp,:udp,:tcp:http,:https,:ldap,:ldaps)
  #  :limit => number of pings to perform (nil => infinite)
  #  :interval => number of seconds to wait between pings
  #  :url => destination url (required for http/s and ldap/s)
  #  :host => host name or IP address (required for icmp,tcp, and udp)
  #  :port => optionally specify the port for host (else default port is assumed)
  #
  def initialize(options = {})
    @options = options
    @limit = options[:limit]
    @interval = options[:interval] || 5
    case options[:type]
    when :icmp
      @ping_handler = Net::Ping::External.new(@options[:host],@options[:port])
    when :udp
      @ping_handler = Net::Ping::UDP.new(@options[:host],@options[:port])
    when :tcp
      @ping_handler = Net::Ping::TCP.new(@options[:host],@options[:port])
    when :http, :https
      @ping_handler = Net::Ping::HTTP.new(@options[:url])
    when :ldap, :ldaps
      @ping_handler = Net::Ping::LDAP.new(@options[:url])
    end
  end

  # main routine to run a complete ping test
  def run
    return unless ping_handler
    header
    ping_count=0
    while (limit.nil? || ping_count < limit) do
      status = ping_handler.ping?
      log status,ping_handler.duration,ping_handler.exception
      ping_count += 1
      sleep interval if (limit.nil? || ping_count < limit)
    end
  end

  # prints the header structure to STDERR
  def header
    $stderr.puts [
      '# It goes PING! .. testing',options[:url],
      (limit ? "#{limit} times - once" : nil),'every',interval,'seconds'
    ].compact.join(' ')
  end

  # logs ping result to STDOUT
  # +args+ is an array of values to log
  def log(*args)
    $stdout.puts(([Time.now.utc.strftime( "%Y-%m-%dT%H:%M:%S.%LZ" )] + args).join(','))
    $stdout.flush
  end
end