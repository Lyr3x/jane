require 'rubygems'
require 'net/telnet'
require 'json'

module Telnet
  def self.config()
    config_path = 
      File.expand_path(
        File.join(
           ENV['JANE_PATH'], 'config', 'telnet.json'
        )
      )
    return JSON.parse(File.read(config_path), symbolize_names: true)
  end

  def self.run(command_parameter)

    host = Net::Telnet::new("Host" => config[:host], "Port" => config[:port])
	host.puts(command_parameter[:command])
	host.close
  end

end
