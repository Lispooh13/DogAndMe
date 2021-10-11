class PostsController < ApplicationController

  def new
    @post = Post.new
    @post.post_images.build
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    if post.save
      flash[:notice] = "投稿が完了しました。"
      redirect_to post_path(post.id)
    else
      render :new
    end
  end

  def index
    @posts = Post.page(params[:page]).reverse_order

  end


  def show
    @post = Post.find(params[:id])

    #変数をJSで使えるようにするため
    gon.post = @post
  end

  def edit
    @post = Post.find(params[:id])
    @post.post_images.build

  end

  def update
    post = Post.find(params[:id])
    post.user_id = current_user.id
    if post.update(post_params)
      flash[:notice] = "変更が完了しました。"
      redirect_to post_path(post)
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to posts_path
  end


  private

  def post_params
    params.require(:post).permit(:place, :address, :purpose, :latitude, :longitude, :body, post_images_images: [])
  end

end