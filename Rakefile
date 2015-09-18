require "rubygems"

#task default: %w[update_cron]

task :light_on do
  system 'ruby', '-r', File.join(ENV['JANE_PATH'], "addons", "sunset.rb"), '-e', "Sunset.run ''"
end

task :update_cron do
  schedule_path = File.join(ENV['JANE_PATH'], 'config', 'schedule.rb')
  `whenever --load-file #{schedule_path} --update-crontab`
end

task :update_timetable do
  timetable_path = File.join(ENV['JANE_PATH'], 'config', 'timetable.rb')
  `whenever --load-file #{timetable_path} --update-crontab`
end

task :start do
  unicorn_config = File.join(ENV['JANE_PATH'], 'unicorn.rb')
  `unicorn -c #{unicorn_config} -E production -D`
end
