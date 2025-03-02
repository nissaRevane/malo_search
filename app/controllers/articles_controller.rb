class ArticlesController < ApplicationController
  def search
    if params[:query].present?
      @articles = Article.search_full_text(params[:query])
    else
      @articles = Article.order(:published_at).last(3)
    end
  end
end
