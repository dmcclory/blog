require 'sinatra'

get '/' do
  "show topics?"
end

get '/chron' do
  "show a view sorted by date"
end

get '/topics' do
  "show a view sorted by topic"
end

get '/blog/:article' do |article|
  "would show: #{article}"
end
