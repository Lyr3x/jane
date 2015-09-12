# Navlinks
require "json"

module Navlinks
  
  def self.path
    ENV['JANE_PATH']
  end
  
  def self.config_file
    File.expand_path(
      File.join(
        path, 'config', 'navlinks.json'
      )
    )
  end

  def self.config
    JSON.parse(File.read(config_file), symbolize_names: true)
  end
end

