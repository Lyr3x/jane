# by default whenever writes bash -l -c 'command...' to crontab
# since we want to run a ruby script we'll write the command ourself
set :job_template, nil

sunset = `ruby ../sunset.rb`
every 1.day, :at => sunset do
	command "ruby" + File.join(File.expand_path(File.dirname(__FILE__)), "..", "addons", "lighton.rb")
end

every 1.day, :at => "1am" do
	command "bash -l -c" + File.join(File.expand_path(File.dirname(__FILE__)), "..", "addons", "wheneverUpdateCron.sh")
end