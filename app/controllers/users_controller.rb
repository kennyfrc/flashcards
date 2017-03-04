class UsersController < ApplicationController
  skip_before_action :require_login, only: [:index, :new, :create]
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    if @user.save
      flash[:noice] = "User successfully created"
      redirect_to root_path
    else
      flash[:error] = "Please enter a valid email or ensure your PW has at least 8 characters"
      render 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_params)
      flash[:notice] = "User successfully updated!"
      redirect_to @user
    else
      flash[:error] = "Please review the errors below."
      render 'edit'
    end
  end

  def show
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
