# cec
module Cec
  def self.run(command_parameter)
    # get powerstatus from cec-client
    system "echo pow 1 | cec-client -s -d 1"
    # parse returned value to standby (true/false)
  end
end
