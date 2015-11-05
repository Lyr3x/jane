# Jane
# require 'sinatra'
require 'json'
require 'sinatra/base'

jane_lib =
  File.expand_path(
    File.join(
      ENV['JANE_PATH'], 'lib', 'jane'
    )
  )

command =
  File.expand_path(
    File.join(
      ENV['JANE_PATH'], 'lib', 'commander'
    )
  )

navlinks =
  File.expand_path(
    File.join(
      ENV['JANE_PATH'], 'lib', 'navlinks'
    )
  )

timetable =
  File.expand_path(
    File.join(
      ENV['JANE_PATH'], 'lib', 'timetable'
    )
  )

ping =
  File.expand_path(
    File.join(
      ENV['JANE_PATH'], 'lib', 'ping'
    )
  )

require jane_lib
require command
require navlinks
require timetable
require ping

class JaneApp < Sinatra::Base
  @@scheudled_jobs = {}
  helpers do
    def render_ui(config)
      ui = ""
      sorted_by_device = {}
      # fill hash with device keys and empty arrays
      config.each do |button|
        if button[:generate_button]
          sorted_by_device[button[:device]] = []
        end
      end
      # write buttons based on device in array at key_device
      config.each do |button|
        if button[:generate_button]
          sorted_by_device[button[:device]] << button
        end
      end
      sorted_by_device.each do |device_name, buttons|
        ui << render_device(device_name, buttons)
      end
      return ui
    end
  
    def render_button(button)
      button_options = {
        class: "btn #{button[:btn_class]} btn-lg btn-block",
        onclick: "run('#{button[:device]}', '#{button[:action]}')"
      }
      icon_tag = "<span class=\"glyphicon glyphicon-#{button[:icon]}\"></span>"
      content = "#{icon_tag} #{button[:label]}"
      "<button #{button_options.map { |k, v| "#{k}=\"#{v}\"" }.join(' ')}>#{content}</button>"
    end
  
    def render_device(device_name, buttons)
      html_device =
      "<div class=\"col-md-4 col-sm-6\"><div class=\"panel panel-default\"><div class=\"panel-heading\" style=\"font-size:1.5em; font-weight:bold\">#{device_name}</div><div class=\"panel-body\">\n"
      
      buttons.each do |button|
        html_device += render_button(button)
      end
      html_device += "</div></div></div>"
      
      @i += 1
      if @i%2==0
        html_device += "<div class=\"clearfix visible-sm-block visible-md-block\"></div>" 
      end
  
      if @i%3==0
        html_device += "<div class=\"clearfix visible-lg-block\"></div>" 
      end
      return html_device
    end
  
    def render_navlinks(navlinks_config)
      html_nav_links = ""
      navlinks_config.each do |link|
        html_nav_links << "<li><a href=\"#{link[:url]}\" target=\"_blank\">#{link[:name]}</a></li>"
      end
      return html_nav_links
    end

    def render_timetable(timetable_config)
      html_timetable = ""
      timetable_config.each do |entry|
        html_timetable << "<div class='panel panel-default'>\n" \
            "<div class='panel-body'>\n" \
              "<button type='button' class='btn btn-xs btn-danger pull-right' onclick='remove_entry(this)'>\n" \
                "<span class='glyphicon glyphicon-remove'></span>\n" \
              "</button>\n" \
              "<div name='entry' class='form-group cron-entry'>\n" \
                "<div class='form-group'>\n" \
                  "<label for='device' class='col-lg-2'>Device</label>\n" \
                  "<input type='text' form='timetable' value=\"#{entry[:device]}\" class='col-lg-8' name='entries[][device]'>\n" \
                "</div>\n" \
                "<div class='form-group'>\n" \
                  "<label for='action' class='col-lg-2'>Action</label>\n" \
                  "<input type='text' form='timetable' value=\"#{entry[:action]}\" class='col-lg-8' name='entries[][action]'>\n" \
                "</div>\n" \
                "<div class='form-group cron-field'>\n" \
                  "<label for='cron' class='col-lg-2'>Cron</label>\n" \
                  "<input type='text' form='timetable' value=\"#{entry[:cron]}\" class='col-lg-8' name='entries[][cron]'>\n" \
                "</div>\n" \
              "</div>\n" \
            "</div>\n" \
          "</div>\n"
        end
      return html_timetable
    end
  end

  
  # render index.erb
  get '/' do
    erb :index
  end
  
  get '/timetable' do
    erb :timetable
  end

  post '/timetable/save' do
    # build entry
    timetable_entries = []
    unless params[:entries].nil?
      params[:entries].each do |e|
        entry = {}
        entry[:device] = e[:device]
        entry[:action] = e[:action]
        entry[:cron] = e[:cron]
        if params[:ping] == "on"
        entry[:ping] = true
        else
          entry[:ping] = false
        end
        timetable_entries << entry
      end
    end
    Timetable.update(timetable_entries)
    redirect to('/')
  end

  get '/button/new' do
    if params[:error] == "duplicate"
      erb :button_error
    else
      erb :button_new
    end
  end
  
  post '/button/save' do
    # make sure that new button has a unique device-action pair
    config = Jane.config
    config.each do |button|
      if button[:device] == params[:device] and button[:action] == params[:action]
        redirect to('/button/new?error=duplicate')
      end
    end
    # build button hash
    button = {}
    button[:label] = params[:label]
    button[:icon] = params[:icon]
    button[:device] = params[:device]
    button[:action] = params[:action]
    button[:btn_class] = params[:color]
    if params[:show] == "on"
      button[:generate_button] = true
    else
      button[:generate_button] = false
    end
    button[:commands] = []
    # build command hash
    params[:commands].each do |input_command|
      command = {}
      command[:addon] = input_command[:addon]
      command[:sleep_after_command] = input_command[:sleep].to_i
      command[:command_parameter] = {}
      input_command[:params].each do |para|
        command[:command_parameter][para[:key]] = para[:value]
      end
      button[:commands] << command
    end
    # save runtime config to file
    config << button
    Jane.save(config)
    redirect to('/')
  end
  
  get '/button/edit' do
  
  end
  
  get '/button/delete' do
    erb :button_delete
  end
  
  post '/button/delete' do
    config = Jane.config
    config.each do |button|
      if button[:device] == params[:device] and button[:action] == params[:action]
        config.delete(button)
      end
    end
    Jane.save(config)
    redirect to('/')
  end
  
  get '/v1' do
    device = params[:device]
    action = params[:action]
    if params[:home] == 'true'
      if Ping.run
        Thread.new{Commander.execute(device, action)}
      else
        return
      end
    end
    Thread.new{Commander.execute(device, action)}
  end
  
  get '/job/list' do
    content_type :json
    return_active_jobs
  end
  
  get '/job/create' do
    content_type :json
    #parse URL params
    device = params[:device]
    action = params[:action]
    sec = params[:sec].to_i or 0
    min = params[:min].to_i or 0
    hour = params[:hour].to_i or 0
    #create job
    delay = sec + (60*min) + (60*60*hour)
    now = Time.now
    job = {start_time: now, end_time: (now + delay), device: device, action: action}
    thr = Thread.new{run_job(delay, device, action)}
    
    @@scheudled_jobs[thr] = job
    return_active_jobs
  end
  
  get '/job/cancel' do
    content_type :json
    id = params[:id].to_i
    @@scheudled_jobs.each_key do |thr|
      if thr.object_id == id
        Thread.kill(thr)
      end
    end
    #wait a bit so thread is dead before cleanup starts
    sleep(0.1)
    return_active_jobs
  end
  
  get '/devices' do 
    content_type :json
    
    list_devices_and_actions.to_json
  end
  
  get '/actions' do
    content_type :json
    device = params[:device]
    list_devices_and_actions[device].to_json
  end
  
  def list_devices_and_actions()
    devices_and_actions = {}
    Jane.config.each do |button|
      if button[:generate_button]
        devices_and_actions[button[:device]] = []
      end
    end
    Jane.config.each do |button|
      if button[:generate_button]
        devices_and_actions[button[:device]].push(button[:action])
      end
    end
    devices_and_actions
  end
  
  def run_job(delay, device, action)
    sleep(delay)
    Commander.execute(device, action)
  end
    
  def remove_from_schedule(thr_id)
    @@scheudled_jobs.delete(thr_id)
  end
  
  def clean_job_list()
    @@scheudled_jobs.each do |thread|
      if !thread[0].status
        @@scheudled_jobs.delete(thread[0])
      end
    end
  end
  
  def return_active_jobs()
    clean_job_list
    active_jobs = []
    @@scheudled_jobs.each do |thr, desc|
      active_jobs.push({device: desc[:device],
                        action: desc[:action],
                        start_time: desc[:start_time].strftime("%H:%M:%S"),
                        end_time: desc[:end_time].strftime("%H:%M:%S"),
                        id: thr.object_id})
    end
    active_jobs.to_json
  end
  
  # sunset inital cron entry
  `rake update_cron`
  Timetable.parse_config
  `rake update_timetable`

end
