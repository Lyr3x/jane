# Jane
require 'sinatra'
require 'json'
require 'net/http'
require 'rake'
require 'rack/cache'

require './lib/jane'
require './lib/command'

# listen to 0.0.0.0 instead of localhost
set :bind, '0.0.0.0'
set :environment, :production

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
    "<div class=\"col-md-4 col-sm-6\"><h3><span class=\"glyphicon glyphicon-#{category_hash[:icon]}\"></span>  #{category_hash[:title]}</h3>
    <div class=\"well\">\n"

    category_hash[:buttons].each do |button|
      html_renderd_category += render_button(button)
    end
    html_renderd_category += "</div></div>"
    
    @i += 1
    if @i%2==0
      html_renderd_category += "<div class=\"clearfix visible-sm-block visible-md-block\"></div>" 
    end

    if @i%3==0
      html_renderd_category += "<div class=\"clearfix visible-lg-block\"></div>" 
    end
    return html_renderd_category
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
        Command.run(command)
      end
    end
  end
end

# sunset inital cron entry
`rake update_cron`
