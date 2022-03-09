class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @newbook = Book.new
    @users = User.all
    @user = current_user
  end
  def show
    @newbook = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
    redirect_to user_path(current_user.id) unless current_user.id == @user.id
  end

  def update
    @user = current_user
    if @user.update(user_params)
     redirect_to user_path(current_user.id)
     flash[:notice] = "You have updated user successfully."
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
