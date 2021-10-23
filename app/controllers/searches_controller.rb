class SearchesController < ApplicationController
  before_action :authenticate_user!,except:[:search]

  def search
   posts = Post.search(params[:keyword])
   @posts = Kaminari.paginate_array(posts).page(params[:page]).per(12)

   # @search = Post.page(params[:page]).order(created_at: :desc).per(12) #全部取ってきちゃうPostモデルに記載してるため

  end
end
