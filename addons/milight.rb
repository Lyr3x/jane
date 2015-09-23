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

  WIFI_BRIDGE_IP = config[:wifi_bridge_ip]
  WIFI_BRIDGE_PORT = config[:wifi_bridge_port]

  ######## GROUP 1 ########
  #define lamp states
  LAMP_ON = "\x45\x00\x55"
  LAMP_OFF = "\x46\x00\x55"

  #define white
  WHITE_INIT = "\x45\x00\x55"
  WHITE_FINISH = "\xC5\x00\x55"

  #define max brightness
  MAX_BRIGHT = "\x4E\x1B\x55"

  #define max dim
  MAX_DIM = "\x4E\x02\x55"

  #define disco mode
  DISCO = "\x4D\x00\x55"

  #define speed states
  SPEED_UP = "\x44\x00\x55"
  SPEED_DOWN = "\x43\x00\x55"

  #define night mode
  NIGHT_MODE = "\xC6\x00\x55"

  def self.on()
    socket = UDPSocket.new
    socket.send(LAMP_ON, 0, WIFI_BRIDGE_IP, WIFI_BRIDGE_PORT)
  end

  def self.off()
    socket = UDPSocket.new
    socket.send(LAMP_OFF, 0, WIFI_BRIDGE_IP, WIFI_BRIDGE_PORT)
  end
  
  def self.white()
    socket = UDPSocket.new
    socket.send(WHITE_INIT, 0, WIFI_BRIDGE_IP, WIFI_BRIDGE_PORT)
    sleep 0.1
    socket.send(WHITE_FINISH, 0, WIFI_BRIDGE_IP, WIFI_BRIDGE_PORT)
  end

  def self.disco()
    socket = UDPSocket.new
    socket.send(DISCO, 0, WIFI_BRIDGE_IP, WIFI_BRIDGE_PORT) 
  end

  def self.faster()
    socket = UDPSocket.new
    socket.send(SPEED_UP, 0, WIFI_BRIDGE_IP, WIFI_BRIDGE_PORT)
  end

  def self.slower()
    socket = UDPSocket.new
    socket.send(SPEED_DOWN, 0, WIFI_BRIDGE_IP, WIFI_BRIDGE_PORT)
  end

  def self.night()
    socket = UDPSocket.new
      t = Time.now
      loop do
        socket.send(LAMP_OFF, 0, WIFI_BRIDGE_IP, WIFI_BRIDGE_PORT)
        break if Time.now > t + 0.1
      end
        socket.send(NIGHT_MODE, 0, WIFI_BRIDGE_IP, WIFI_BRIDGE_PORT)

  def self.run(command_parameter)
  case command_parameter[:command]
    when "on"
      on
    when "off"
      off
    when "white"
      white
    when "disco"
      disco
    when "faster"
      faster
    when "slower"
      slower
    when "night"
      night
    else puts "unknown command"
  end

end