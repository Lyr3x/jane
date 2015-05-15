# tvpower
lirc = File.expand_path(
        File.join(
          ENV['JANE_PATH'], 'addons', 'lirc'
        )
       )
require lirc

module Tvpower
  def self.run(command_parameter)
    # get powerstatus from tvservice
    powerstatus = `/opt/vc/bin/tvservice -s`
    powerstatus = powerstatus.split[1]
    powerstatus = powerstatus[-1]
    lirc_command = {device: "tv", task: "KEY_POWER"}
    if ((powerstatus == "2" or powerstatus == "a") and command_parameter[:task] == "off") or \
       ((powerstatus == "1" or powerstatus == "9") and command_parameter[:task] == "on")
       Lirc.run(lirc_command)
    end
  end
end
