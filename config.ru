require "rubygems"
require "sinatra"
jane = File.expand_path(
        File.join(
            ENV['JANE_PATH'], 'jane.rb'
        )
       )
require jane

run Jane
