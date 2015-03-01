require "net/http"
require "./jane"

module Command
  def self.run(command)
    type = command[:type]
    parameter = command[:command_parameter]
    device = parameter[:receiving_device]
    task = parameter[:task]
    powerpi_ip = Jane.config[:powerpi_server]
    sleep_time = command[:sleep_after_command]
    addon_name = command[:name]

    if type == 'addon'
      addon(addon_name, sleep_time)
    elsif type == 'powerpi'
      powerpi(device, task, sleep_time, powerpi_ip)
    elsif type == 'irsend'
      irsend(device, task, sleep_time)
    end
  end

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

  def self.addon(addon_name, sleep_time)
    addon_path =  File.expand_path(
                    File.join(
                      File.dirname(__FILE__), '..', "addons", "#{addon_name}"
                    )
                  )
    load addon_path
    sleep(sleep_time.to_i)
  end
end
