class PostsController < ApplicationController
  before_action :authenticate_user!,except: [:index, :show]
  before_action :ensure_user, only:[:edit, :update, :destroy]

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
    @post_comment = PostComment.new
  end


  def edit
    @post_images = @post.post_images
  end


  def update
    if @post.update(post_params)
      flash[:notice] = "変更が完了しました。"
      redirect_to post_path(@post)
    else
      @post_images = @post.post_images
      render :edit
    end
  end


  def destroy
    @post.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to posts_path
  end

#ハッシュタグ一覧
  def hashtag
    @user = current_user
    if params[:name].nil?
      @hashtags = Hashtag.all.to_a.group_by{|hashtag| hashtag.post.count}
    else
      @hashtag = Hashtag.find_by(hashname: params[:name])
      @post = @hashtag.posts.page(params[:page]).per(20).reverse_order
      @hashtags = Hashtag.all.to_a.group_by{ |hashtag| hashtag.posts.count}
    end
  end


  private

  def post_params
    params.require(:post).permit(:place, :address, :category, :purpose, :latitude, :longitude, :body, :hashbody,  post_images_images: [], hashtag_ids: [])
  end


  def ensure_user
    @post = Post.find(params[:id])
     unless @post.user == current_user
     redirect_to posts_path
     end
  end

end