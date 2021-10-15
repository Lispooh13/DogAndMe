class UsersController < ApplicationController

  def index
    @user = current_user
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).order(created_at: :desc).per(8)
    @dogs = @user.dogs
  end
  
  #いいね一覧
  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorites_posts = Post.find(favorites)
  end


  def edit
    @user = User.find(params[:id])
  end


  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       flash[:notice] = "プロフィールを更新しました。"
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :profile_image, :introduction)
    end
    

end
