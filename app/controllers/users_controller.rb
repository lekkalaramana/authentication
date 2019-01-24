class UsersController < ApplicationController
	def new 
	end

	def create
		user = User.new(user_params)
		if user.save
			session[:user_id] = user.id
			flash[:success] = "Successfully Created User!"
			redirect_to root_path
		else
			flash[:warning] = "Invalid Email or Password"
			redirect_to '/signup'
		end
	end

	private

	def user_params
		params.permit(:name, :email, :password, :password_confirmation)
	end
end
