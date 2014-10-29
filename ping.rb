require 'rubygems'
require 'net/ping'

kai = Net::Ping::TVP.new('ip')
repeat = 5
if kai.ping?