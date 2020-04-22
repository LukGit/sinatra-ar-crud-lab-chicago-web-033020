
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
  end

  # Index
  get "/articles/?" do
    @articles = Article.all
    erb :index
  end

  # New
  get "/articles/new" do
    erb :new
  end

  # Show
  get "/articles/:id" do
    find_article
    erb :show
  end
  
  # Create
  post "/articles" do
    # article = Article.new(title: params[:title], content: params[:content])
    article = Article.create(title: params[:title], content: params[:content])
    # article.save
    redirect "/articles/#{article.id}"
  end

  # Edit
  get "/articles/:id/edit" do
    find_article
    erb :edit
  end
  
  # Update
  patch "/articles/:id" do
    find_article
    @article.update(title: params[:title], content: params[:content])
    redirect "/articles/#{@article.id}"
  end

  # Delete

  delete "/articles/:id" do
    find_article
    @article.destroy
    redirect "/articles"
  end
  
  
  private

  def find_article
    @article = Article.find(params[:id])
  end
end
