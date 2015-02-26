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

  def self.addon(name)
    addon_path =  File.expand_path(
                    File.join(
                      File.dirname(__FILE__), '..', "addons", "#{name}"
                    )
                  )
    load addon_path
  end
end
