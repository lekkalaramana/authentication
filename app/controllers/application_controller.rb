class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

	rescue_from CanCan::AccessDenied do |exception|
		flash[:error] = 'Access Denied.'
		redirect_to root_url
	end

	def current_user
		@current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
	end

	helper_method :current_user

	def authenticate_user!
		binding.pry
		redirect_to '/login' unless current_user
	end
end
