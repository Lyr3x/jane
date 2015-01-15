# Jane
require 'sinatra'
require 'rufus-scheduler'
require 'json'
require 'net/http'
require 'rake'

require './lib/jane'

# listen to 0.0.0.0 instead of localhost
set :bind, '0.0.0.0'

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
config[:categories].each do |category|
  category[:buttons].each do |button|
    route = "/#{button[:fn_args].join('/')}"
    send(:get, route) do
      #this doesnt make sense for powerpi url calls
      system button[:command]
    end
  end
end

# sunset inital cron entry
#Rake.application['update_cron'].invoke()
`rake update_cron`

# Timer
# timer(Time.now + 1 * 60, "Lampe aus")
