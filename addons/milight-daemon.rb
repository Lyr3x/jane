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
    uuri = URI('http://localhost:8080/on')
    req = Net::HTTP::Post.new(uri)
    req.set_form_data('group' => '1')

    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end

    case res
      when Net::HTTPSuccess, Net::HTTPRedirection
      # OK
    else
      res.value
    end
  end
end
