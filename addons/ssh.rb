require 'rubygems'
require 'net/ssh'
require 'json'

module Ssh
  def self.config()
    config_path = 
      File.expand_path(
        File.join(
           ENV['JANE_PATH'], 'config', 'ssh.json'
        )
      )
    return JSON.parse(File.read(config_path), symbolize_names: true)
  end

  def self.run(command_parameter)
    ssh_config = config
    HOST = ssh_config[:host]
    USER = ssh_config[:user]
    PASSWORD = ssh_config[:password]
    Net::SSH.start(HOST, USER, :password => PASSWORD) do |ssh|
      ssh.open_channel do |channel|
        channel.request_pty do |ch, success|
          if success
            puts "Successfully obtained pty"
          else
            puts "Could not obtain pty"
          end
        end
    
        channel.exec(command_parameter[:commands].join(';')) do |ch, success|
          abort "Could not execute commands!" unless success
    
          channel.on_data do |ch, data|
            puts "#{data}"
            channel.send_data "#{PASSWORD}\n" if data =~ /password/
          end
    
          channel.on_extended_data do |ch, type, data|
            puts "stderr: #{data}"
          end
    
          channel.on_close do |ch|
            puts "Channel is closing!"
          end
        end
      end
      ssh.loop
    end
  end

end
