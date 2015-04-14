require "rubygems"

#task default: %w[update_cron]

task :light_on do
  system 'ruby', File.join(ENV['JANE_PATH'], "addons", "sunset.rb")
end

task :update_cron do
  schedule_path = File.join(ENV['JANE_PATH'], 'config', 'schedule.rb')
  `whenever --load-file #{schedule_path} --update-crontab`
end
