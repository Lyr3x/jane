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
set :bind, '0.0.0.0'
set :environment, :production

# use Rack::Cache,
#   :verbose => true,
#     :metastore   => 'file:public/cache/meta',
#     :entitystore => 'file:public/cache/body',
#     :default_ttl => 604800

helpers do
  def render_ui(config)
    ui = ""
    sorted_by_device = {}
    # fill hash with device keys and empty arrays
    config.each do |button|
      sorted_by_device[button[:device]] = []
    end
    # write buttons based on device in array at key_device
    config.each do |button|
      sorted_by_device[button[:device]] << button
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
end

# render index.erb
get '/' do
  erb :index
end

get '/v1' do
  device = params[:device]
  action = params[:action]
  Commander.execute(device, action)
  return "done"
end

# sunset inital cron entry
`rake update_cron`
