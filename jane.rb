# Jane
require 'sinatra'
require 'json'
require 'net/http'
require 'rake'
require 'rack/cache'

require './lib/jane'
require './lib/command'

# listen to 0.0.0.0 instead of localhost
set :environment, :production
set :bind, '0.0.0.0'

use Rack::Cache,
  :verbose => true,
    :metastore   => 'file:public/cache/meta',
    :entitystore => 'file:public/cache/body',
    :default_ttl => 604800

helpers do
  def render_button(btn_desc)
    button_options = {
      class: "btn #{btn_desc[:btn_class]} btn-lg btn-block",
      onclick: "jane(#{btn_desc[:fn_args].map { |arg| "'#{arg}'" }.join(',')})"
    }
    icon_tag = "<span class=\"glyphicon glyphicon-#{btn_desc[:icon]}\"></span>"
    content = "#{icon_tag} #{btn_desc[:name]}"
    "<button #{button_options.map { |k, v| "#{k}=\"#{v}\"" }.join(' ')}>#{content}</button>"
  end

  def render_category(category_hash)
    html_renderd_category =
    "<h3><span class=\"glyphicon glyphicon-#{category_hash[:icon]}\"></span>  #{category_hash[:title]}</h3>
    <div class=\"well\">\n"

    category_hash[:buttons].each do |button|
      html_renderd_category += render_button(button)
    end
    html_renderd_category += '</div>'
    # return html_renderd_category
  end
end

# render index.erb
get '/' do
  erb :index
end

config = Jane.config
powerpi_server = config[:powerpi_server]
config[:categories].each do |category|
  category[:buttons].each do |button|
    route = "/#{button[:fn_args].join('/')}"
    send(:get, route) do
      button[:commands].each do |command|
        if command[:type] == "powerpi"
          Command.powerpi command[:command_parameter][:receiving_device], 
                          command[:command_parameter][:task],
                          command[:sleep_after_command],
                          powerpi_server
        end
        if command[:type] == "irsend"
          Command.irsend command[:command_parameter][:receiving_device], 
                          command[:command_parameter][:task],
                          command[:sleep_after_command]
        end
        if command[:type] == "addon"
          Command.addon command[:name], command[:sleep_after_command]
        end
      end
    end
  end
end

# sunset inital cron entry
`rake update_cron`
