class PostsController < ApplicationController
	before_action :signed_in_user, only: [:new, :create]
	def new
	end

	def create
	end

	def index
	end
end
