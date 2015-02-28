home_check_ping_lib_path = 
  File.expand_path(
    File.join(
      File.dirname(__FILE__), '..', 'lib', 'home_check_ping_mod'
    )
  )
require home_check_ping_lib_path

class HomeCheckPing
  
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

  def reachable
    threads = []
    @server.each do |target|
      threads << Thread.new{ping target, @ping_count}
    end
    threads.each { |th| th.join }

    return @one_server_up
  end
end
