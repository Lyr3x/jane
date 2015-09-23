#!/usr/bin/ruby
require 'socket'
require 'json'
module Milight
  def self.config()
      milight_config = File.expand_path(
                       File.join(
                         ENV['JANE_PATH'], 'config', 'milight.json'
                       )
                     )
      return JSON.parse(File.read(milight_config), symbolize_names: true)
    end

  # master list of commands here: http://www.limitlessled.com/dev/

  wifi_bridge_ip = config[:wifi_bridge_ip]
  wifi_bridge_port = config[:wifi_bridge_port]

  ######## GROUP 1 ########
  #define lamp states
  lamp_on = "\x45\x00\x55"
  lamp_off = "\x46\x00\x55"

  #define white
  white_init = "\x45\x00\x55"
  white_finish = "\xC5\x00\x55"

  #define max brightness
  max_bright = "\x4E\x1B\x55"

  #define max dim
  max_dim = "\x4E\x02\x55"

  #define disco mode
  disco = "\x4D\x00\x55"

  #define speed states
  speed_up = "\x44\x00\x55"
  speed_down = "\x43\x00\x55"

  #define night mode
  night_mode = "\xC6\x00\x55"

  def self.on()
    socket = UDPSocket.new
    socket.send(lamp_on, 0, wifi_bridge_ip, wifi_bridge_port)
  end

  def self.off()
    socket = UDPSocket.new
    socket.send(lamp_off, 0, wifi_bridge_ip, wifi_bridge_port)
  end
  
  def self.white()
    socket = UDPSocket.new
    socket.send(white_init, 0, wifi_bridge_ip, wifi_bridge_port)
    sleep 0.1
    socket.send(white_finish, 0, wifi_bridge_ip, wifi_bridge_port)
  end

  def self.run(command_parameter)
    case command_parameter[:command]
      when "on"
        on()
    end
  end

end



  ######################old stuff#########################
  # case ARGV[0]
  # when "on"
  #   socket = UDPSocket.new
  #   socket.send(lamp_on, 0, wifi_bridge_ip, wifi_bridge_port)
    
  # when "off"
  #   socket = UDPSocket.new
  #   socket.send(lamp_off, 0, wifi_bridge_ip, wifi_bridge_port)
    
  # when "maxbright"
  #     socket = UDPSocket.new
  #     socket.send(max_bright, 0, wifi_bridge_ip, wifi_bridge_port)
    
  # when "maxdim"
  #     socket = UDPSocket.new
  #     socket.send(max_dim, 0, wifi_bridge_ip, wifi_bridge_port) 

  # when "disco"
  #     socket = UDPSocket.new
  #     socket.send(disco, 0, wifi_bridge_ip, wifi_bridge_port) 

  # when "faster"
  #   socket = UDPSocket.new
  #   socket.send(speed_up, 0, wifi_bridge_ip, wifi_bridge_port)
    
  # when "slower"
  #   socket = UDPSocket.new
  #   socket.send(speed_down, 0, wifi_bridge_ip, wifi_bridge_port)

  # when "white"
  #     socket = UDPSocket.new
  #     socket.send(white_init, 0, wifi_bridge_ip, wifi_bridge_port)
  #     sleep 0.1
  #     socket.send(white_finish, 0, wifi_bridge_ip, wifi_bridge_port)

  # when "night"
  #     socket = UDPSocket.new
  #     t = Time.now
  #     loop do
  #       socket.send(lamp_off, 0, wifi_bridge_ip, wifi_bridge_port)
  #       break if Time.now > t 
  #     end
  #       socket.send(night_mode, 0, wifi_bridge_ip, wifi_bridge_port)

  # when "color"
  #   #set color argument to be an integer
  #   passed_color = ARGV[1].to_i
  #   #puts "passed_color is #{passed_color}"

  #   #convert that to a hex value
  #   colorcode = passed_color.to_s(16)
  #   #puts "hex color code is #{colorcode}"
    
  #   #send the value being sure to encode the color code into hex
  #   set_color = "\x40#{colorcode.hex.chr}\x55"
  #   socket = UDPSocket.new
  #   socket.send(set_color, 0, wifi_bridge_ip, wifi_bridge_port)
    
  # else puts "usage: milight.rb [on|off|max(bright|dim)|disco|faster|slower|white|night|color (1-255)]"
  # end