class SearchesController < ApplicationController
  def search
   @posts = Post.search(params[:keyword])
  @posts_page = Post.page(params[:page]).reverse_order

  end
end
