class ArticlesController < ApplicationController
  def search
    @articles = Article.order(:published_at).last(3)
  end
end
