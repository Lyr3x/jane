require 'rubygems'
require 'json'

module Eiscp
  def self.config()
    config_path = 
      File.expand_path(
        File.join(
           ENV['JANE_PATH'], 'config', 'eiscp.json'
        )
      )
    return JSON.parse(File.read(config_path), symbolize_names: true)
  end

  def self.run(command_parameter)

    host = config[:host]
    `onkyo --host #{host} #{command_parameter[:command]}`
  end

end
