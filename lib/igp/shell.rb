require 'uri'

# class that groks the igp command line options and invokes the ping task
class Igp::Shell
  # holds the parsed options
  attr_reader :options
  # holds the URI object representing the ping target
  attr_reader :uri

  # initializes the shell with command line argments:
  #
  # +options+ is expected to be the hash structure as provided by GetOptions.new(..)
  #
  # +args+ is the remaining command line arguments
  #
  def initialize(options, args)
    defaults = {
      interval: 1
    }
    @options = defaults.merge((options || {}).each { |k, v| { k => v } })
    return unless args.first

    resolve_addressing args.first
    normalise_options
  end

  protected

  # decodes the +host+ string to type, host, port and sets the uri
  def resolve_addressing(host)
    @uri = URI.parse(host)
    unless uri.scheme
      @options[:type] = :icmp
      @options[:host] = uri.to_s
      @options[:url] = "#{@options[:type]}://#{@options[:host]}"
      return
    end
    @options[:url] = uri.to_s
    @options[:type] = uri.scheme.to_sym
    @options[:port] = uri.port
    @options[:host] = uri.host
  end

  # sets defaults where required
  def normalise_options
    @options[:interval] = @options[:interval].to_i
    @options[:limit] = @options[:limit].to_i if @options[:limit]
  end

  public

  # runs the ping task
  def run
    case options[:type]
    when :icmp, :http, :https, :tcp, :udp, :ldap, :ldaps
      Igp::Base.new(options).run
    else
      usage
    end
  end

  # defines the valid command line options
  OPTIONS = %w[help verbose interval=i limit=i].freeze

  # prints usage/help information
  def usage
    self.class.usage
  end

  # prints usage/help information
  def self.usage
    $stderr.puts <<~EOS

      It goes PING! v#{Igp::VERSION}
      ===================================

      Usage:
        igp [options] uri

      Options:
        -h | --help    :shows command help
        -i= | --interval=seconds (default: 1 second)
        -l= | --limit=number of tests (default: infinite)

      The uri specifies the protocol, hostname and port.
      The ICMP protocol is assumed if not specified.
      The default well-known port is assumed if not specified.

      Examples:

        ICMP ping:
          igp localhost
          igp icmp://localhost

        UDP/TCP ping:
          igp udp://localhost:123
          igp tcp://localhost:843

        HTTP/S ping:
          igp http://localhost:8080
          igp https://localhost:4443

        LDAP/S ping:
          igp ldap://localhost
          igp ldaps://localhost:6636

    EOS
  end
end
