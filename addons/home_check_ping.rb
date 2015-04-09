require "json"

module HomeCheckPing
  def run()
    config = JSON.parse(
              File.read(File.expand_path(ENV['JANE_PATH'], 'config', 'ping.json')),
              symbolize_names: true
            )
    threads = []
    one_server_up = false
    config[:hosts].each do |target|
      threads << Thread.new{ping target, config[:ping_count].to_i}
    end
    threads.each { |th| th.join }
    return one_server_up
  end

  def initialize 
    @config = HomeCheckPingMod.config
    @server = @config[:hosts]
    @ping_count = @config[:ping_count].to_i
    @one_server_up = false
  end
  
  def ping(ping_target, ping_count)
    result = `ping -q -i 0.2 -c #{ping_count} #{ping_target}`
    if ($?.exitstatus == 0)
      @one_server_up = true
    end
  end
end
