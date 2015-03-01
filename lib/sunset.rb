# sunset
jane_lib_path =
  File.expand_path(
    File.join(
      File.dirname(__FILE__), '..', 'lib', 'jane'
    )
  )

command =
  File.expand_path(
    File.join(
      File.dirname(__FILE__), '..', 'lib', 'command'
    )
  )

require "json"
require jane_lib_path
require command
require "net/http"

module Sunset
  def self.config_file
    File.expand_path(
      File.join(
        File.dirname(__FILE__),
        '..', 'config', 'sunset.json'
      )
    )
  end

  def self.config
    JSON.parse(File.read(config_file), symbolize_names: true)
  end

  def self.sunset_time
    city_id = config[:cityID]
    uri = URI('http://api.openweathermap.org/data/2.5/weather?id=' + city_id.to_s)
    sunset_time = JSON.parse(Net::HTTP.get(uri), symbolize_names:true)
    sunset_time = Time.at(sunset_time[:sys][:sunset])
    return sunset_time
  end

  def self.light_on
    jane_config = Jane.config
    jane_config[:categories].each do |category|
      category[:buttons].each do |button|
        if button[:name] == config[:light_button_name]
          button[:commands].each do |command|
            Command.run(command)
          end
        end
      end
    end
  end

end
