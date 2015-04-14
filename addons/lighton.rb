ping =
  File.expand_path(
    File.join(
      ENV['JANE_PATH'], 'addons', 'ping'
    )
  )

sunset =
  File.expand_path(
    File.join(
      ENV['JANE_PATH'], 'addons', 'sunset'
    )
  )

require "net/http"
require ping
require sunset

if Ping.run
  Sunset.run
end
