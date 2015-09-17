set :job_template, nil 

every '0 0 * * *' do
  `curl -G --data-urlencode "device=lampe" --data-urlencode "action=on" "http://localhost/v1"`
end

every '0 0 * * *' do
  `curl -G --data-urlencode "device=test" --data-urlencode "action=entry" "http://localhost/v1"`
end

