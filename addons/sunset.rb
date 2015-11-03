# sunset
ping = File.expand_path(
        File.join(
          ENV['JANE_PATH'], 'addons', 'ping'
        )
       )

apicall = File.expand_path(
        File.join(
          ENV['JANE_PATH'], 'addons', 'apicall'
        )
       )

require "json"
require "net/http"
require ping
require apicall

module Sunset
  def self.config_file
    File.expand_path(
      File.join(
        ENV['JANE_PATH'], 'config', 'sunset.json'
      )
    )
  end

  def self.config
    JSON.parse(File.read(config_file), symbolize_names: true)
  end

  def self.sunset_time
    city_id = config[:cityID]
    api_key = config[:apiKey]
    uri = URI("http://api.openweathermap.org/data/2.5/weather?id=#{city_id}&appid=#{api_key}")
    sunset_time = JSON.parse(Net::HTTP.get(uri), symbolize_names:true)
    sunset_time = Time.at(sunset_time[:sys][:sunset])
    return sunset_time
  end

  def self.run(command_parameters)
    if Ping.run(nil)
      config[:lights].each do |light|
        APICall.call(light[:device], light[:action])
      end
    end
  end

end
