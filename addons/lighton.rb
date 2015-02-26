home_check_ping_path = 
  File.expand_path(
    File.join(
      File.dirname(__FILE__), 'home_check_ping'
    )
  )

sunset = 
  File.expand_path(
    File.join(
      File.dirname(__FILE__), '..', 'lib', 'sunset'
    )
  )

require "net/http"
require home_check_ping_path
require sunset

if HomeCheckPing.new.reachable
  #lighton_command returns a String containing a Net:Http.get... command
  #so this doesnt make sense
  system Sunset.lighton_command
end
