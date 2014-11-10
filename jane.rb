#Jane
require 'sinatra'
require 'rufus-scheduler'
require './addons/sunset'
require 'yaml'

#listen to 0.0.0.0 instead of localhost
set :bind, '0.0.0.0'

helpers do
  def render_button(btn_desc)
  	html_renderd_button = "<button type=\"button\" 
  		class=\"btn #{btn_desc[:btn_class]} btn-lg btn-block\" 
  		onclick=\"jane("
  			
  		btn_desc[:fn_args].each do |fn_arg|
  			html_renderd_button += "'#{fn_arg}',"
  		end
  		html_renderd_button = html_renderd_button[0..-2] + ")\">"
  		
  		html_renderd_button += "<span class=\"glyphicon glyphicon-#{btn_desc[:icon]}\"></span>
  		#{btn_desc[:name]}</button>"
  end

  def render_category(category_hash)
  	html_renderd_category = 
  	"<h3><span class=\"glyphicon glyphicon-#{category_hash[:icon]}\"></span>  #{category_hash[:title]}</h3>
  	<div class=\"well\">\n"
  	
  	category_hash[:buttons].each do |button|
  		html_renderd_category += render_button(button)
  	end
  	html_renderd_category += "</div>"
  	return html_renderd_category
  end
end

#render index.erb
get '/' do
	erb :index
end

config = YAML.load_file("config.yml")

config.each do |category|
	category[:buttons].each do |button|
		route = "/"
		button[:fn_args].each do |arg|
			route += arg + "/"
		end
		route = route[0..-2]
		self.send(:get, route) do
			eval(button[:command])
		end
	end
end

#decide if you want to use the sunset function
useSunsetFunction = true

#Sunset light
if useSunsetFunction 
	scheduler = Rufus::Scheduler.new
	sunsettime = Sunset.new("Bonn")

	scheduler.cron '0 1 * * *' do
		#every day at 1 am
		sunsettime = Sunset.new("Bonn")
	end

	scheduler.at sunsettime.sunset do
		#check if you are home (ping your smartphone)
		#command to turn lights on here
	end
end
