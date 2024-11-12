class SearchController < ApplicationController
  def index
    @search = Post.ransack(params[:q])  # Ensure @search is being set
    @products = @search.result  # Get search results
  end
end
