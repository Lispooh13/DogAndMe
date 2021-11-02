class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_user, only:[:edit, :update]

  def index
    @user = current_user
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).order(created_at: :desc).per(15)
  end

  #いいね一覧
  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorites_posts = Post.where(id: favorites).page(params[:page]).order(created_at: :desc).per(15)
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

  def ensure_user
    @user = User.find(params[:id])
     unless @user == current_user
     redirect_to user_path(@user)
     end
  end

end
