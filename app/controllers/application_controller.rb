class ApplicationController < ActionController::Base
  before_action :require_login
  protect_from_forgery with: :exception

  private

  def not_authenticated
    redirect_to signin_path, alert: "Please sign in or register first"
  end
end
