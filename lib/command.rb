require "net/http"

module Command
  def self.powerpi(device, task, sleep_time)
    ip = "192.168.2.25"
    if task == "on"
      task = 1
    end
    Net::HTTP.get(URI("http://#{ip}/lib/powerpi.php?action=setsocket&socket=#{device}&status=#{task}"))
    sleep(sleep_time.to_i)
  end

  def self.irsend(device, task, sleep_time)
    system "irsend SEND_ONCE #{device} #{task}"
    sleep(sleep_time.to_i)
  end
end
