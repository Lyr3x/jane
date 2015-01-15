# sunset
require "json"
require "./jane"

module Sunset
  def self.config_file
    File.expand_path(
      File.join(
        File.dirname(__FILE__),
        '..', 'config', 'sunset.json'
      )
    )
  end

  def self.config
    JSON.parse(File.read(config_file), symbolize_names: true)
  end

  def self.city
    config[:city]
  end

  def self.lighton_command
    jane_config = Jane.config
    sunset_config = config
    jane_config[:categories].each do |category|
      category[:buttons].each do |button|
        if button[:name].eql? config[:light_on_button_name]
          return button[:command]
        end
      end
    end
  end

end
