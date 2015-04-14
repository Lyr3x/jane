require "json"

module Ping
  @ping_status = []
  def self.run()
    config = JSON.parse(
              File.read(File.expand_path(File.join(ENV['JANE_PATH'], 'config', 'ping.json'))),
              symbolize_names: true
            )
    threads = []

    start = Time.now
    config[:hosts].each do |target|
      threads << Thread.new{ping(target, config[:ping_count].to_i)}
    end
    threads.each { |th| th.join }
    if @ping_status.include? true
      p Time.now - start
      return true
    end
    p Time.now - start
    return false
  end
  
  def self.ping(ping_target, ping_count)
    `ping -q -i 0.2 -c #{ping_count} #{ping_target}`
    if ($?.exitstatus == 0)
      @ping_status << true
      return true
    end
    @ping_status << false
  end
end
