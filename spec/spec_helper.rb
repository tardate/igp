require 'igp'
require 'stringio'

def capture(*streams)
  streams.map!(&:to_s)
  begin
    result = StringIO.new
    streams.each { |stream| eval "$#{stream} = result # $#{stream} = result" }
    yield
  ensure
    streams.each { |stream| eval("$#{stream} = #{stream.upcase} # $#{stream} = #{stream.upcase}") }
  end
  result.string
end
