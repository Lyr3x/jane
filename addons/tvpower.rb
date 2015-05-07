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
    powerstatus = powerstatus[-1].to_i
    lirc_command = {device: "tv", task: "KEY_POWER"}
    if (powerstatus == 2 and command_parameter[:task] == "off") or \
       (powerstatus == 1 and command_parameter[:task] == "on")
      Lirc.run(lirc_command)
    end
    # if tv is on: state 0x40002 [NTSC 4:3], 720x480 @ 60.00Hz, interlaced
    # if tv is off: state 0x40001 [NTSC 4:3], 720x480 @ 60.00Hz, interlaced
  end
end
