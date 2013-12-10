require 'timeout'

class Phantomjs
  attr_accessor :timeout

  def initialize(script, *args)
    @script = script
    @args = args
    @timeout = 20
  end

  def run
    pipe = nil
    begin
      Timeout.timeout(@timeout) do
        pipe = IO.popen(["phantomjs", @script] + @args)
        Process.wait pipe.pid
        return pipe.read
      end
    rescue Timeout::Error
      Process.kill 9, pipe.pid
      Process.wait pipe.pid
      return "Couldn't render page... orz."
    end
  end
end
