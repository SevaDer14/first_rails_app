class Api::ArticlesController < ApplicationController

  def index
    articles = Article.all
    render json: { articles: articles }
  end

  def show
    article = Article.find(params['id'])    
    render json: {article: article}
  end
  
  def create 
    article = Article.create(params[:article].permit(:title, :body))

    if article.persisted? 
      render json: { message: 'Your article is successfully created' }, status: 201
    else
      render json: { message: article.errors.full_messages.to_sentence }, status: 422
    end    
  end
end
