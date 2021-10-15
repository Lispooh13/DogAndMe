class DogsController < ApplicationController
  before_action :authenticate_user!

  def index
    #投稿している人の、dogを持ってきたい
    @user = current_user
    @dog = Dog.new
    @dogs = @user.dogs
  end

  def create
    @dog = Dog.new(dog_params)
    @dog.user_id = current_user.id
    if @dog.save
      redirect_to dogs_path
    else
      @user = current_user
      @dog = Dog.new
      @dogs = @user.dogs
      render :index
    end
  end

  def destroy
    dog = Dog.find(params[:id])
    dog.destroy
    redirect_to dogs_path
  end

  private

  def dog_params
    params.require(:dog).permit(:name, :dog_type, :dog_size)
  end
end
