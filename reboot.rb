require 'rubygems'
require 'net/ssh'

HOST = '192.168.2.101' 
USER = 'jarvis' 
PASS = 'jarvis'  

Net::SSH.start( HOST, USER, :password => PASS ) do|ssh| 
	result = ssh.exec!('reboot') 
	puts result 
end 
