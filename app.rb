require 'sinatra'
require 'psych'
require 'redcarpet'

class Blog
  def initialize(articles_dir = nil)
    @articles_dir = articles_dir || "articles"
    @articles = load_articles
  end

  def load_articles
    articles = []
    Dir[@articles_dir + "/*.md"].each do |article_path|
      metadata = Psych.load(File.read(article_path).split(/---/)[1])
      metadata["file"] = File.basename(article_path, ".md")
      articles << metadata
    end
    articles
  end

  def markdown_for(article_id)
    article_path = File.join(@articles_dir, article_id + ".md")
    metadata, text = File.read(article_path).split(/---/)[1..2]
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    markdown.render(text)
  end

  def metadata_for(article_id)
    article_path = File.join(@articles_dir, article_id + ".md")
    metadata, text = File.read(article_path).split(/---/)[1..2]
    Psych.load(metadata)
  end

  def sorted_by_topic
    @articles.group_by { |article| article["category"] || "random" }
  end

  def sorted_by_month
    @articles.group_by { |article| Date.parse("#{article['date'].year}-#{article['date'].month}-01")}.sort { |a, b| b[0] <=> a[0] }
  end
end

get '/' do
  blog = Blog.new
  @articles = blog.sorted_by_topic
  erb :topics
end

get '/chron' do
  blog = Blog.new
  @articles = blog.sorted_by_month
  erb :chron
end

get '/topics' do
  blog = Blog.new
  @articles = blog.sorted_by_topic
  erb :topics
end

get '/about' do
  erb :about
end

get '/blog/:article' do |article_id|
  blog = Blog.new
  @metadata = blog.metadata_for(article_id)
  @contents = "<h3>" + blog.markdown_for(article_id)+ "</h3>"
  erb :article
end
