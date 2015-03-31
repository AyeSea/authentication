class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :signed_in?, :current_user

  def sign_in(user)
  	cookies.permanent[:remember_token] = User.new_token
    cookies.permanent.signed[:user_id] = user.id
    user.update_attribute(:remember_token, User.digest(cookies.permanent[:remember_token]))
    session[:user_id] = user.id
    current_user = user
	end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.remember_token == User.digest(cookies.permanent[:remember_token])
        @current_user = user
      end
    end
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    @current_user.update_attribute(:remember_token, nil)
    cookies.delete(:remember_token)
    cookies.delete(:user_id)
    session.delete(:user_id)
    current_user = nil
  end

  def signed_in_user
    unless signed_in?
      flash[:danger] = "Only members can write posts! Sign in if you're a member."
      redirect_to signin_path
    end
  end
end