class PostsController < ApplicationController
	before_action :signed_in_user, only: [:new, :create]
	
	def new
		@post = Post.new
	end

	def create
		@post = current_user.posts.create(post_params)
		if @post.save
			flash[:success] = 'Post created!'
			redirect_to posts_path
		else
			flash.now[:error] = 'Post must be between 5 to 150 characters!'
			render 'new'
		end
	end

	def index
		@posts = Post.all
	end

	private
		def post_params
			params.require(:post).permit(:body)
		end
end
