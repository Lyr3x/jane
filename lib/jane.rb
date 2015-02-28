# Jane
module Jane
  
  def self.path
    File.expand_path(
      File.join(
        File.dirname(__FILE__), '..'
      )
    )
  end
  
  def self.config_file
    File.expand_path(
      File.join(
        File.dirname(__FILE__),
        '..', 'config', 'config.json'
      )
    )
  end

  def self.config
    JSON.parse(File.read(config_file), symbolize_names: true)
  end
end

