class PostsController < ApplicationController
before_action :ensure_correct_user, only:[:edit, :destroy]

  def new
    @post = Post.new
    @post.post_images.build
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "投稿が完了しました。"
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def index
    @posts = Post.page(params[:page]).reverse_order

  end


  def show
    @post = Post.find(params[:id])
    @user = @post.user
    #変数をJSで使えるようにするため
    gon.post = @post
  end

  def edit
    @post = Post.find(params[:id])
    @post_images = @post.post_images
  end

  def update
    @post = Post.find(params[:id])
    @post.user_id = current_user.id
    # @post_images = @post.post_images
    # if @post_images.count > 6
    #   flash[:notice] = "最大6枚までです。"
    #   render :edit

    # end

    if @post.update(post_params)
      flash[:notice] = "変更が完了しました。"
      redirect_to post_path(@post)
    else
      @post = Post.find(params[:id])
      @post_images = @post.post_images
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to posts_path
  end


  private

  def post_params
    params.require(:post).permit(:place, :address, :purpose, :latitude, :longitude, :body, post_images_images: [])
  end


  def ensure_correct_user
    @post = Post.find(params[:id])
     unless @post.user == current_user
     redirect_to posts_path
     end
  end

end