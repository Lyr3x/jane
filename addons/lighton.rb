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
  #lighton_command returns a String containing a Net:Http.get... command
  #so this doesnt make sense
  system Sunset.lighton_command
end
