class SearchesController < ApplicationController
  before_action :authenticate_user!,except:[:search]

  def search
   posts = Post.search(params[:keyword])
   @posts = Kaminari.paginate_array(posts).page(params[:page]).per(15)
  end
end
