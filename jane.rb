# Jane
require 'sinatra'
require 'json'
require 'net/http'
require 'rake'
require 'rack/cache'

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

require jane_lib
require command

# listen to 0.0.0.0 instead of localhost
set :environment, :production
set :bind, '0.0.0.0'
set :environment, :production

use Rack::Cache,
  :verbose => true,
    :metastore   => 'file:public/cache/meta',
    :entitystore => 'file:public/cache/body',
    :default_ttl => 604800

$scheudled_jobs = {}

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
      onclick: "jane('#{button[:device]}', '#{button[:action]}')"
    }
    icon_tag = "<span class=\"glyphicon glyphicon-#{button[:icon]}\"></span>"
    content = "#{icon_tag} #{button[:label]}"
    "<button #{button_options.map { |k, v| "#{k}=\"#{v}\"" }.join(' ')}>#{content}</button>"
  end

  def render_device(device_name, buttons)
    html_device =
    "<div class=\"col-md-4 col-sm-6\"><h3>#{device_name}</h3><div class=\"well\">\n"
    # <span class=\"glyphicon glyphicon-#{category_hash[:icon]}\"></span>  
    
    buttons.each do |button|
      html_device += render_button(button)
    end
    html_device += "</div></div>"
    
    @i += 1
    if @i%2==0
      html_device += "<div class=\"clearfix visible-sm-block visible-md-block\"></div>" 
    end

    if @i%3==0
      html_device += "<div class=\"clearfix visible-lg-block\"></div>" 
    end
    return html_device
  end

  def config_parser(config)
    device_action_hash = {}
    config.each do |button|
      if button[:generate_button]
        device_action_hash[button[:device]] = []
      end
    end
    config.each do |button|
      if button[:generate_button]
        device_action_hash[button[:device]].push(button[:action])
      end
    end
    
    return device_action_hash
  end

  def list_devices(config)
    renderd = ""
    device_action_hash = config_parser(config)

    device_action_hash.keys.each do |device|
      renderd += "<option value=\"#{device}\">#{device}</option>\n"
    end
    return renderd
  end

  def list_actions(config)
    renderd = ""
    device_action_hash = config_parser(config)
    all_actions = []
    
    device_action_hash.each do |device, actions|
      actions.each do |action|
        unless all_actions.include? action
          all_actions.push(action)
        end
      end
    end
    all_actions.each do |action|
      renderd += "<option value=\"#{action}\">#{action}</option>\n"
    end
    return renderd
  end

end

# render index.erb
get '/' do
  erb :index
end

get '/v1' do
  expires 1, :public, :must_revalidate
  device = params[:device]
  action = params[:action]
  Commander.execute(device, action)
end

get '/job/list' do
  expires 1, :public, :must_revalidate
  content_type :json
  return_active_jobs
end

get '/job/create' do
  expires 1, :public, :must_revalidate
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
  
  $scheudled_jobs[thr] = job
  return_active_jobs
end

get '/job/cancel' do
  expires 1, :public, :must_revalidate
  content_type :json
  id = params[:id].to_i
  $scheudled_jobs.each_key do |thr|
    if thr.object_id == id
      Thread.kill(thr)
    end
  end
  #wait a bit so thread is dead before cleanup starts
  sleep(0.1)
  return_active_jobs
end

def run_job(delay, device, action)
  sleep(delay)
  Commander.execute(device, action)
end
  
def remove_from_schedule(thr_id)
  $scheudled_jobs.delete(thr_id)
end

def clean_job_list()
  $scheudled_jobs.each do |thread|
    if !thread[0].status
      $scheudled_jobs.delete(thread[0])
    end
  end
end

def return_active_jobs()
  clean_job_list
  active_jobs = []
  $scheudled_jobs.each do |thr, desc|
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
