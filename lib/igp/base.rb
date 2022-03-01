# main class that runs the ping task
class Igp::Base
  # holds the parsed options
  attr_reader :options
  # the output formatter
  attr_reader :formatter
  # the Net::Ping handler for the specific protocol required
  attr_reader :ping_handler
  # number of pings to perform (nil => infinite)
  attr_reader :limit
  # number of seconds to wait between pings (default = 5)
  attr_reader :interval

  # expects a configuration hash as +options+ which may contain:
  #  :type => symbol indicating protocol to use (:icmp,:udp,:tcp:http,:https,:ldap,:ldaps)
  #  :limit => number of pings to perform (nil => infinite)
  #  :interval => number of seconds to wait between pings (default = 5)
  #  :url => destination url (required for http/s and ldap/s)
  #  :host => host name or IP address (required for icmp,tcp, and udp)
  #  :port => optionally specify the port for host (else default port is assumed)
  #
  def initialize(options = {})
    @formatter = Format.new
    @options = options
    @limit = options[:limit]
    @interval = options[:interval] || 5
    case options[:type]
    when :icmp
      @ping_handler = Net::Ping::External.new(@options[:host], @options[:port])
    when :udp
      @ping_handler = Net::Ping::UDP.new(@options[:host], @options[:port])
    when :tcp
      @ping_handler = Net::Ping::TCP.new(@options[:host], @options[:port])
    when :http, :https
      @ping_handler = Net::Ping::HTTP.new(@options[:url])
    when :ldap, :ldaps
      @ping_handler = Net::Ping::LDAP.new(@options[:url])
    end
  end

  # main routine to run a complete ping test
  def run
    return unless ping_handler && formatter

    formatter.header(
      '# It goes PING! .. testing', options[:url],
      (limit ? "#{limit} times - once" : nil),
      'every', interval, 'seconds'
    )
    ping_count = 0
    while limit.nil? || ping_count < limit
      status = ping_handler.ping?
      formatter.log(status, formatter.duration(ping_handler.duration), ping_handler.exception)
      ping_count += 1
      sleep interval if limit.nil? || ping_count < limit
    end
  end

  # handle output formating tasks
  class Format
    TIME_FORMAT = '%Y-%m-%dT%H:%M:%S.%LZ'.freeze

    # prints the header structure to STDERR
    def header(*args)
      $stderr.puts(args.compact.join(' '))
    end

    # logs ping result to STDOUT
    # +args+ is an array of values to log
    def log(*args)
      $stdout.puts(([Time.now.utc.strftime(TIME_FORMAT)] + args).join(','))
      $stdout.flush
    end

    # formats the duration for output. nil duration remains nil
    def duration(duration)
      format('%.6f', duration) if duration
    end
  end
end
