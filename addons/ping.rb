require 'rubygems'
require 'net/ping'
require '../lib/home_check_ping.rb'

include Net

Ping::TCP.service_check = true

#add several hosts you want to ping
config = HomeCheckPing.config
hosts = config[:hosts]
threads = []
ping_objects = []

hosts.each do |ip|
   ping_objects << Net::Ping::TCP.new(ip)
   threads << Thread.new(ip, ping_objects.last) do |ip, p|
     loop do
      if p.ping == true
        #execute commands here
      else
        # 5 min sleeptime if no host is available
        sleep 300
      end
      #10 min sleep when host is available
      sleep 600
     end
   end
end
threads.each { |th| th.join }
