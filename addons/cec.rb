# cec
module Cec
  def self.run(command_parameter)
    # get powerstatus from tvservice
    system "/opt/vc/bin/tvservice -s"
    # if tv is on: state 0x12001a [HDMI CEA (16) RGB lim 16:9], 1920x1080 @ 60.00Hz, progressive
    # if tv is off: state 0x120019 [HDMI CEA (16) RGB lim 16:9], 1920x1080 @ 60.00Hz, progressive
    # parse returned value to standby (true/false)
  end
end
