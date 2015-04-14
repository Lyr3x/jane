jane_lib =
  File.expand_path(
    File.join(
      ENV['JANE_PATH'], 'lib', 'jane'
    )
  )

require "rubygems"
require jane_lib

#task default: %w[update_cron]

task :light_on do
  system 'ruby', File.join(Jane.path, "addons", "lighton.rb")
end

task :update_cron do
  schedule_path = File.join(Jane.path, 'config', 'schedule.rb')
  `whenever --load-file #{schedule_path} --update-crontab`
end
