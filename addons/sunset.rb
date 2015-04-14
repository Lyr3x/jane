# sunset
ping = File.expand_path(
        File.join(
          ENV['JANE_PATH'], 'addons', 'ping'
        )
       )

require "json"
require "net/http"
require ping

if __FILE__ == $0
  run
end

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
    uri = URI('http://api.openweathermap.org/data/2.5/weather?id=' + city_id.to_s)
    sunset_time = JSON.parse(Net::HTTP.get(uri), symbolize_names:true)
    sunset_time = Time.at(sunset_time[:sys][:sunset])
    return sunset_time
  end

  def self.run
    if Ping.run
      config[:lights].each do |light|
        uri = URI("http://localhost:4567/v1?device=#{light[:device]}&action=#{light[:action]}")
        Net::HTTP.get(uri)
      end
    end
  end

end
