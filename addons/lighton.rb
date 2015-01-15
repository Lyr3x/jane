home_check_ping_path = 
  File.expand_path(
    File.join(
      File.dirname(__FILE__), 'home_check_ping'
    )
  )
require "net/http"
require home_check_ping_path

if HomeCheckPing.new.reachable
  Net::HTTP.get(URI('http://192.168.2.123:4567/socket/lamp/on'))
end
