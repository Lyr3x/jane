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

# use Rack::Cache,
#   :verbose => true,
#     :metastore   => 'file:public/cache/meta',
#     :entitystore => 'file:public/cache/body',
#     :default_ttl => 604800

$scheudled_jobs = []

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

  def list_scheudled_jobs
    renderd = '<ul class="list-group">'
    puts $scheudled_jobs
    $scheudled_jobs.each do |job|
      renderd += "<li class=\"list-group-item\"><b>End Time</b> #{job[:end_time].strftime("%H:%M:%S")}  <b>Start Time</b> #{job[:start_time].strftime("%H:%M:%S")}  <b>Device</b> #{job[:device]}  <b>Action</b> #{job[:action]}</li>"  
    end
    renderd += '</ul>'
  end
end

# render index.erb
get '/' do
  $scheudled_jobs.delete_if{|job| job[:end_time] < Time.now}
  erb :index
end

get '/v1' do
  expires 1, :public, :must_revalidate
  device = params[:device]
  action = params[:action]
  Commander.execute(device, action)
end

get '/timer' do
  expires 1, :public, :must_revalidate
  device = params[:device]
  action = params[:action]
  sec = params[:sec].to_i or 0
  min = params[:min].to_i or 0
  hour = params[:hour].to_i or 0
  delay = sec + (60*min) + (60*60*hour)

  now = Time.now
  job = {start_time: now, end_time: (now + delay), device: device, action: action}
  $scheudled_jobs.push(job)
  puts job
  
  Thread.new do 
    sleep(delay)
    Commander.execute(device, action)
  end
  redirect to('/')
end

# sunset inital cron entry
`rake update_cron`
