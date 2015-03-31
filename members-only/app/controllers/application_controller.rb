class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def sign_in(user)
  	remember_token = User.create_token
  	cookes.permanent[:remember_token] = remember_token
  	#Update methods in User model before uncommenting below:
  	#user.remember_token = User.encrypt_token(remember_token)
		
		#Set current user equal to user (needs current user helper)
	end


end
