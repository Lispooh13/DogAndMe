class DogsController < ApplicationController
  before_action :authenticate_user!

  def index
    @dog = Dog.new
    @dogs = Dog.where(user_id: params[:user_id])
    @user = User.find(params[:user_id])
  end

  def create
    @dog = Dog.new(dog_params)
    @dog.user_id = params[:user_id]
    if @dog.save
      redirect_to user_dogs_path(current_user)
    else
      @dog = Dog.new
      @user = User.find(params[:user_id])
      @dogs = @user.dogs
      render :index
    end
  end

  def destroy
    dog = Dog.find(params[:id])
    dog.destroy
    redirect_to user_dogs_path(current_user)
  end

  private

  def dog_params
    params.require(:dog).permit(:name, :dog_type, :dog_size)
  end
end
