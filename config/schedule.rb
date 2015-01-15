# by default whenever writes bash -l -c 'command...' to crontab
# since we want to run a ruby script we'll write the command ourself
jane_lib_path =
  File.expand_path(
    File.join(
      File.dirname(__FILE__), '..', 'lib', 'jane'
    )
  )

sunset_lib_path =
  File.expand_path(
    File.join(
      File.dirname(__FILE__), '..', 'lib', 'sunset_mod'
    )
  )

require jane_lib_path
require sunset_lib_path
require File.join(Jane.path, 'addons', 'sunset.rb')

set :job_template, nil


sunset = Sunset.new sunset_lib_path.city

every 1.day, at: sunset.time do
  rake 'lighton'
end

every 1.day, at: '1am' do
  rake 'update_cron'
end
