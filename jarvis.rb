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
<<<<<<< HEAD
	`irsend SEND_ONCE avr KEY_POWER`
		sleep(2)
	`irsend SEND_ONCE tv KEY_POWER`
=======
  	`irsend SEND_ONCE avr KEY_POWER`
                sleep(2)
   	`irsend SEND_ONCE tv KEY_POWER`
>>>>>>> c02522407749abf2aa5b9a0b270b6e922ea30a92
end

#power on tv
get '/tv_power' do
	`irsend SEND_ONCE tv KEY_POWER`
end

#power on avr
get '/avr_power' do
	`irsend SEND_ONCE avr KEY_POWER`
end

#power on htpc
get '/htpc_power' do
<<<<<<< HEAD
	
=======

>>>>>>> c02522407749abf2aa5b9a0b270b6e922ea30a92
end

