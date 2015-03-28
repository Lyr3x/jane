# home_check
require "json"
module HomeCheckPingMod
  def self.config_file
    File.expand_path(
      File.join(
        ENV['JANE_PATH'], 'config', 'home_check_ping.json'
      )
    )
  end

  def self.config
    JSON.parse(File.read(config_file), symbolize_names: true)
  end
end
