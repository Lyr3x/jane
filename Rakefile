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

task :stop do
  begin
    unicorn_pid = File.read(File.join(ENV['JANE_PATH'], 'tmp', 'pids', 'unicorn.pid')).to_i
  rescue Errno::ENOENT
    raise "Unicorn doesn't seem to be running"
  end
  Process.kill :QUIT, unicorn_pid
end

task :restart do
  Rake::Task["stop"].invoke
  Rake::Task["start"].invoke
end
