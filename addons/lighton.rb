require "net/http"
require "./home_check_ping"

if HomeCheckPing.new.reachable
  Net::HTTP.get(URI('http://192.168.2.123:4567/socket/lamp/on'))
end
