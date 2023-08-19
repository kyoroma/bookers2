class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  
  def index
    @users = User.all
  end
  
  def create
  end
  
  def show
    @user = User.includes(:books).find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_params)
      redirect_to root_path, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :email, :password, :password_confirmation, :current_password)
  end
end
