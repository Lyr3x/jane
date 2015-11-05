# API-Call
require 'net/http'

module APICall
    def self.call(device, action)
        uri = URI('http://127.0.0.1/v1')
        params = { :device => device, :action => action }
        uri.query = URI.encode_www_form(params)
        Net::HTTP.get(uri)
    end
end
  
