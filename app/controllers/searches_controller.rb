class SearchesController < ApplicationController
  before_action :authenticate_user!,except:[:search]
  def search
   @posts = Post.search(params[:keyword])
   @posts_page = Post.page(params[:page]).limit(10) #全部取ってきちゃうPostモデルに記載してるため

  end
end
