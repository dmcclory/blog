require 'sinatra'
require 'redcarpet'

get '/' do
  erb :index
end

get '/chron' do
  erb :chron
end

get '/topics' do
  erb :topics
end

get '/blog/:article' do |article|
  metadata, text = File.read("articles/" + article + '.md').split(/---/)[1..2]
  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
  @contents = "<h3>" + markdown.render(text) + "</h3>"
  erb :article
end
