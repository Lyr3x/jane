require "./lib/jane"

task default: %w[update_cron]

task :lighton do
  system 'ruby', File.join(Jane.path, "addons", "lighton.rb")
end

task :update_cron do
  #system 'bash -l -c', 'whenever --load-file', File.join(Jane.path, 'config', 'schedule.rb'), ' --update-crontab'
  schedule_path = File.join(Jane.path, 'config', 'schedule.rb')
  `whenever --load-file #{schedule_path} --update-crontab`
end
