class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]
  def new
    @user = User.new
  end

  def create
    if login(params[:signin][:email], params[:signin][:password])
      flash[:notice] = 'Login successful'
      redirect_to root_path
    else
      flash[:error] = 'Login failed'
      render 'new'
    end
  end

  def destroy
    logout
    flash[:notice] = 'Logged out'
    redirect_to root_path
  end
end
