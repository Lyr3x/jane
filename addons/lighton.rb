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
  #eval is evil, so try to come up with a different solution
  eval(Sunset.lighton_command)
end
