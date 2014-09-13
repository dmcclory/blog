require 'sinatra'
require 'psych'
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

  def sorted_by_topic
    articles = []
    Dir[@articles_dir + "/*.md"].each do |article_path|
      metadata = Psych.load(File.read(article_path).split(/---/)[1])
      metadata["file"] = File.basename(article_path, ".md")
      articles << metadata
    end
    articles.group_by { |article| article["category"] || "random" }
  end
end

get '/' do
  blog = Blog.new
  @articles = blog.sorted_by_topic
  erb :topics
end

get '/chron' do
  erb :chron
end

get '/topics' do
  blog = Blog.new
  @articles = blog.sorted_by_topic
  erb :topics
end

get '/blog/:article' do |article_id|
  blog = Blog.new
  @contents = "<h3>" + blog.markdown_for(article_id)+ "</h3>"
  erb :article
end
