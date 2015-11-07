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