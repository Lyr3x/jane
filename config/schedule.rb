# by default whenever writes bash -l -c 'command...' to crontab
# since we want to run a ruby script we'll write the command ourself
# jane_lib_path =
#   File.expand_path(
#     File.join(
#       File.dirname(__FILE__), '..', 'lib', 'jane'
#     )
#   )

sunset_lib_path =
  File.expand_path(
    File.join(
      File.dirname(__FILE__), '..', 'lib', 'sunset'
    )
  )

# require jane_lib_path
require sunset_lib_path
#require "/Users/nesurion/Development/Jane/lib/sunset.rb"
#require File.join(Jane.path, 'addons', 'sunset')

set :job_template, nil

every 1.day, at: Sunset.sunset_time do
  rake 'light_on'
end

every 1.day, at: '1am' do
  rake 'update_cron'
end
