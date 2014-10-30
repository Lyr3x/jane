require 'rubygems'
require 'net/ping'

include Net

Ping::TCP.service_check = true

#add several hosts you want to ping
hosts = ['192.168.2.109', '192.168.2.5']
threads = []
ping_objects = []

hosts.each do |ip|
   ping_objects << Net::Ping::TCP.new(ip)
   threads << Thread.new(ip, ping_objects.last) do |ip, p|
     loop do
      if p.ping == true
        puts "#{ip}"
        # execute commands
        else
        # sleeptime if no host is available
        sleep 240
      end

       sleep 2
     end
   end
end
threads.each { |th| th.join }
