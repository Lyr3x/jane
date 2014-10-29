require 'rubygems'
require 'net/ping'

include Net

Ping::TCP.service_check = true

kai = Net::Ping::TCP.new('192.168.2.109')
repeat = 5

(1..repeat).each do

	if kai.ping?
	  puts "TCP ping successful"
	else
	  puts "TCP ping unsuccessful: " + kai.exception
	end
end