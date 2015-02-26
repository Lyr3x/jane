# sunset
jane_lib_path =
  File.expand_path(
    File.join(
      File.dirname(__FILE__), '..', 'lib', 'jane'
    )
  )

require "json"
require jane_lib_path
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

  def self.lighton_command
    jane_config = Jane.config
    sunset_config = config
    command = ""
    jane_config[:categories].each do |category|
      category[:buttons].each do |button|
        if button[:name].eql? config[:light_on_button_name]
          command = button[:command]
        end
      end
    end
    return command
  end

end
