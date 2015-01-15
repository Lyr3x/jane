# by default whenever writes bash -l -c 'command...' to crontab
# since we want to run a ruby script we'll write the command ourself
require "/Users/nesurion/Development/Jane/lib/jane"
require File.join(Jane.path, 'addons', 'sunset.rb')
set :job_template, nil

sunset = Sunset.new 'Bonn'

every 1.day, at: sunset.time do
  rake 'lighton'
end

every 1.day, at: '1am' do
  rake 'update_cron'
end
