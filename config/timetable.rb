set :job_template, nil 

every '0 0 * * *' do
  command "ruby -r $JANE_PATH/lib/apicall.rb -e \"APICall.call 'lampe', 'on'\""
end

every '0 0 * * *' do
  command "ruby -r $JANE_PATH/lib/apicall.rb -e \"APICall.call 'test', 'entry'\""
end

every '0 0 * * *' do
  command "ruby -r $JANE_PATH/lib/apicall.rb -e \"APICall.call 'foo', 'baa'\""
end

