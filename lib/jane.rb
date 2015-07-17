# Jane
require "json"

module Jane
  
  def self.path
    ENV['JANE_PATH']
  end
  
  def self.config_file
    File.expand_path(
      File.join(
        path, 'config', 'config.json'
      )
    )
  end

  def self.config
    JSON.parse(File.read(config_file), symbolize_names: true)
  end

  def self.save(config)
    file = File.open(config_file, "w")
    file.write(JSON.pretty_generate(config))
    file.close
  end
end

