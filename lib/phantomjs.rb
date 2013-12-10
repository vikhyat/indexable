require 'timeout'

class Phantomjs
  def self.run(script, *args)
    pipe = nil
    begin
      Timeout.timeout(20) do
        pipe = IO.popen(["phantomjs", script] + args)
        Process.wait pipe.pid
        return pipe.read
      end
    rescue Timeout::Error
      Process.kill 9, pipe.pid
      Process.wait pipe.pid
      return "Couldn't render page... orz"
    end
  end
end
