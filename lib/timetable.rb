# Timetable
require "json"

module Timetable
  
  def self.path
    ENV['JANE_PATH']
  end
  
  def self.timetable_json
    File.expand_path(
      File.join(
        path, 'config', 'timetable.json'
      )
    )
  end

  def self.timetable_rb
    File.expand_path(
      File.join(
        path, 'config', 'timetable.rb'
      )
    )
  end

  def self.config
    JSON.parse(File.read(timetable_json), symbolize_names: true)
  end

  def self.entry_str(entry)
    command = "every \'#{entry[:cron]}\' do\n" \
              "  command \"ruby -r $JANE_PATH/lib/apicall.rb -e \\\"APICall.call '#{entry[:device]}', '#{entry[:action]}, '#{entry[:home]}'\\\"\"\n" \
              "end\n\n"
    return command
  end

  def self.parse_config()
    update(config)
  end

  def self.update(entries)
    # build timetable.rb
    timetable_ruby = "set :job_template, nil \n\n"
    entries.each do |entry|
      timetable_ruby += entry_str(entry)
    end
    file = File.open(timetable_rb, "w")
    file.write(timetable_ruby)
    file.close

    # build timetable.json
    file = File.open(timetable_json, "w")
    file.write(JSON.pretty_generate(entries))
    file.close
    `rake update_timetable`
  end

end
