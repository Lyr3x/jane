require "net/http"

module Command
  def self.powerpi(device, task, sleep_time, powerpi_ip)
    if task == "on"
      task = 1
    end
    Net::HTTP.get(URI("http://#{powerpi_ip}/lib/powerpi.php?action=setsocket&socket=#{device}&status=#{task}"))
    sleep(sleep_time.to_i)
  end

  def self.irsend(device, task, sleep_time)
    system "irsend SEND_ONCE #{device} #{task}"
    sleep(sleep_time.to_i)
  end
end
