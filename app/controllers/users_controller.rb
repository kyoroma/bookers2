class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  
  def index
    @users = User.all
    @books = Book.all
  end
  
  def create
    @user = current_user.books.build(user_params)

    if @user.save
      flash[:notice] = "User was successfully created."
      redirect_to user_path(user.id)
    else
      render :new
    end
  end
  
  def show
    @user = User.find(params[:id])
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
