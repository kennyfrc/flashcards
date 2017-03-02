class UsersController < ApplicationController
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

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
