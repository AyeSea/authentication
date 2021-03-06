class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email])
  	if user && user.authenticate(params[:session][:password])
  		flash[:success] = 'Log In Successful!'
  		sign_in user
  		redirect_to user
  	else
  		flash.now[:error] = 'Log in Failed!'
  		render 'new'
  	end
  end

  def destroy
    sign_out if signed_in?
    flash[:success] = 'Logged Out! Until next time...'
    redirect_to root_path
  end
end
