require 'sinatra'
require 'redcarpet'

class Blog
  def initialize(articles_dir = nil)
    @articles_dir = articles_dir || "articles"
  end

  def markdown_for(article_id)
    article_path = File.join(@articles_dir, article_id + ".md")
    metadata, text = File.read(article_path).split(/---/)[1..2]
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    markdown.render(text)
  end
end

get '/' do
  erb :index
end

get '/chron' do
  erb :chron
end

get '/topics' do
  erb :topics
end

get '/blog/:article' do |article_id|
  blog = Blog.new
  @contents = "<h3>" + blog.markdown_for(article_id)+ "</h3>"
  erb :article
end
