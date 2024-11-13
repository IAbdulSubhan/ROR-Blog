class SearchController < ApplicationController
  after_action :empty_search, only: :index
  def index
    @search = Post.ransack(params[:q])
    # puts @search.inspect  # Debugging line
    @posts = @search.result(distinct: true)
  end

  private
  def empty_search
    @posts = []
  end
end
