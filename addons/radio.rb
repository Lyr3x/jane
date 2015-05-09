# radio

module Radio
  def self.get_config()
    radio_config = File.expand_path(
                     File.join(
                       ENV['JANE_PATH'], 'config', 'radio.json'
                     )
                   )
    JSON.parse(File.read(radio_config), symbolize_names: true)
  end

  def self.run(command_parameter)
    code_hash = {"a" => 1, "b" => 2, "c" => 3, "d" => 4, "e" => 5, "f" => 6}
    on_off_hash = {"off" => 0, "on" => 1}
    radiosend = File.expand_path(
                  File.join(
                    ENV['JANE_PATH'], 'lib', 'radiosend'
                  )
                )
    config = get_config
    config.each do |remote|
      remote[:devices].each do |device, code|
        if device.to_s == command_parameter[:receiving_device]
          system "#{radiosend} #{remote[:systemcode]} #{code_hash[code]} #{on_off_hash[command_parameter[:task]]}"
          puts "#{radiosend} #{remote[:systemcode]} #{code_hash[code]} #{on_off_hash[command_parameter[:task]]}"
        else
        end
      end
    end
  end
end
