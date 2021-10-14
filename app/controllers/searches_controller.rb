class SearchesController < ApplicationController
  def search
   @posts = Post.search(params[:keyword])
   @posts_page = Post.page(params[:page]).limit(10) #全部取ってきちゃう…Postモデルに記載してるため

  end
end
