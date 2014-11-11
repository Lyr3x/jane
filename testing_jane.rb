require "./addons/sunset.rb"
require 'rufus-scheduler'
require "yaml"

# sunset = Sunset.new("Bonn")

# puts sunset.time

# job = Rufus::Scheduler.new

# time = Time.new
# time = (time + 5).to_s[0..18]
# puts time

# job.at(time) do
# 	puts "geht"
# end

# job.join
config = {
	:useSunset => true,
	:city 	   => "Bonn"
}

puts config.to_yaml