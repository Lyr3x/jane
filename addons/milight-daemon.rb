require 'rubygems'
require 'json'

module Milight
  def self.config()
    config_path = 
      File.expand_path(
        File.join(
           ENV['JANE_PATH'], 'config', 'milight.json'
        )
      )
    return JSON.parse(File.read(config_path), symbolize_names: true)
  end

  def self.run(command_parameter)
    milight = File.expand_path(
                  File.join(
                    config[:executable]
                  )
                )
  uri = URI('http://localhost:8080')
  # res = Net::HTTP.post_form(uri, '#{command_parameter[:command]}' => '#{command_parameter[:group]}')
  res = Net::HTTP.post_form(uri, 'on' => 'group=1')
  puts res.body
  end
end
