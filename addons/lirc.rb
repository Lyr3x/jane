#lirc

module Lirc
  def self.run(command_parameter)
    system "irsend SEND_ONCE #{command_parameter[:device]} #{command_parameter[:task]}"
  end
end
