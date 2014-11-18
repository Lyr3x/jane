require 'net/http'
require 'rufus-scheduler'
require File.join(File.expand_path(File.dirname(__FILE__)), "addons", "sunset.rb")
require 'yaml'
require 'sinatra'

sunset_config = YAML.load_file(File.join(File.expand_path(File.dirname(__FILE__)), 'config' ,'config_sunset.yml'))
jane_config = YAML.load_file(File.join(File.expand_path(File.dirname(__FILE__)), 'config' ,'config.yml'))

sunset = Sunset.new(sunset_config[:city])
puts sunset.time

# File.open("log", 'w') { |file| file.write("your text") }
# jane_config.each do |category|
# 	category[:buttons].each do |button|
# 		if button[:name] == sunset_config[:light_button_name]
# 			puts button[:command]
# 		end
# 	end
# end
# light_on_command = ""

# puts light_on_command
# eval(light_on_command)
# Net::HTTP.get(URI('http://192.168.2.123:4567/socket/lamp/off'))


job = Rufus::Scheduler.new

# job.at '2014-11-18 17:55:00' do
job.every '3s' do
	puts "job!"
	jane_config.each do |category|
	category[:buttons].each do |button|
		if button[:name] == sunset_config[:light_button_name]
			light_on_command = button[:command]
			# file.puts "executed command"
    end
  end
end
end
