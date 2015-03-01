jane_lib_path =
  File.expand_path(
    File.join(
      File.dirname(__FILE__), '..', 'lib', 'jane'
    )
  )

require "net/http"
require jane_lib_path

module Command
  def self.run(command)
    type = command[:type]

    if type == 'addon'
      addon(command[:name],
            command[:sleep_after_command]
            )
    elsif type == 'powerpi'
      powerpi(command[:command_parameter][:receiving_device],
              command[:command_parameter][:task],
              command[:sleep_after_command],
              Jane.config[:powerpi_server]
              )
    elsif type == 'irsend'
      irsend(command[:command_parameter][:receiving_device],
             command[:command_parameter][:task],
             command[:sleep_after_command]
             )
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
