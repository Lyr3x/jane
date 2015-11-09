require 'rubygems'
require 'json'
require 'net/http'

module Milight
  def self.config()
    config= 
      File.expand_path(
        File.join(
           ENV['JANE_PATH'], 'config', 'milight.json'
        )
      )
    # if there is no config file we create an empty one to 
    # ensure that the /milight/config endpoint works
    if !File.exist?(config)
      emptyHash = {}
      File.open(config,"w") do |f|
        f.write(emptyHash.to_json)
      end
    end
    return JSON.parse(File.read(config), symbolize_names: true)
  end

  def self.run(command_parameter)
    uri = URI("http://#{config[:host]}:#{config[:port]}/#{command_parameter[:command]}?group=#{command_parameter[:group]}&#{command_parameter[:option]}=#{command_parameter[:value]}")
    req = Net::HTTP::Post.new(uri)
    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end
  end
end
