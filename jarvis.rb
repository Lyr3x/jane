#Jarvis Brain
require 'sinatra'

#listen to 0.0.0.0 instead of localhost
set :bind, '0.0.0.0'

get '/' do
	erb :index
end

#Power commands
#power on/off all devices
get '/power' do
	`touch power`
	'created test file'
end

#power on tv
get '/tv_power' do
	`irsend SEND_ONCE tv KEY_POWER`
end

#power on avr
get '/avr_power' do

end

#power on htpc
get '/htpc_power' do

end

