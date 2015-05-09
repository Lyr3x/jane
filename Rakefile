require "rubygems"

#task default: %w[update_cron]

task :light_on do
  system 'ruby', '-r', File.join(ENV['JANE_PATH'], "addons", "sunset.rb"), '-e', "Sunset.run ''"
end

task :update_cron do
  schedule_path = File.join(ENV['JANE_PATH'], 'config', 'schedule.rb')
  `whenever --load-file #{schedule_path} --update-crontab`
end
