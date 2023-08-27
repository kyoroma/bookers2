class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]

  def index
    @users = User.all
    @books = Book.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "Profile successfully updated!"
    else
      flash.now[:alert] = "Error updating user."
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :email, :password, :password_confirmation, :current_password, :profile_image)
  end
end
