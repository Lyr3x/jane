require "rubygems"
require "./lib/jane"

task default: %w[update_cron]

task :light_on do
  system 'ruby', File.join(Jane.path, "addons", "lighton.rb")
end

task :update_cron do
  schedule_path = File.join(Jane.path, 'config', 'schedule.rb')
  `whenever --load-file #{schedule_path} --update-crontab`
end
