home_check_ping_path = 
  File.expand_path(
    File.join(
      File.dirname(__FILE__), 'home_check_ping'
    )
  )

sunset_mod = 
  File.expand_path(
    File.join(
      File.dirname(__FILE__), '..', 'lib', 'sunset_mod'
    )
  )

require "net/http"
require home_check_ping_path
require sunset_mod

if HomeCheckPing.new.reachable
  sunset_mod.lighton_command
end
