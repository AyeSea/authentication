class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def sign_in(user)
  	new_remember_token = User.create_token
  	cookies.permanent[:remember_token] = new_remember_token
    user.update_attribute(:remember_token, User.digest(new_remember_token))
    current_user = user
	end

  def current_user
    #if user w/ given remember token exists:
    if User.find_by(:remember_token, User.digest(cookies[:remember_token]))
      @current_user ||= User.find_by(:remember_token, User.digest(cookies[:remember_token]))
    else
      nil
    end
  end

  def current_user=(user)
    @current_user = user
  end

  def signed_in?
    !current_user.nil?
  end
end