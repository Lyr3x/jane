# tvPower
module TvPower
  def self.run(command_parameter)
    # get powerstatus from tvservice
    powerstatus = `/opt/vc/bin/tvservice -s`
    powerstatus = powerstatus.split[1]
    p powerstatus
    powerstatus = powerstatus[-1].to_i
    p powerstatus
    if powerstatus == 1
      return true
    else
      return false
    end
    # if tv is on: state 0x40001 [NTSC 4:3], 720x480 @ 60.00Hz, interlaced
    # if tv is off: state 0x40002 [NTSC 4:3], 720x480 @ 60.00Hz, interlaced
    # parse returned value to standby (true/false)
  end
end
