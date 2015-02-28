sunset_lib_path =
  File.expand_path(
    File.join(
      File.dirname(__FILE__), '..', 'lib', 'sunset'
    )
  )

require sunset_lib_path

set :job_template, nil

every 1.day, at: Sunset.sunset_time do
  rake 'light_on'
end

every 1.day, at: '1am' do
  rake 'update_cron'
end
