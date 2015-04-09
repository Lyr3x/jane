jane_lib_path =
  File.expand_path(
    File.join(
      ENV['JANE_PATH'], 'lib', 'jane'
    )
  )

require jane_lib_path

module Commander

  def self.execute(device, action)
    addons_path = File.expand_path(File.join(ENV['JANE_PATH'], 'addons'))
    config = Jane.config
    config.each do |button|
      if button[:device] == device and button[:action] == action
        button[:commands].each do |command|
          addon = File.join(addons_path, command[:addon])
          require addon
          addon = addon.split('/')[-1]
          addon = addon.capitalize!
          mod = Object.const_get(addon)
          mod.run(command[:command_parameter])
          sleep(command[:sleep_after_command])
        end
      end
    end
  end

end
