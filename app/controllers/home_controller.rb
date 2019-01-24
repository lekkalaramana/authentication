class HomeController < ApplicationController
  def index
  	if current_user
  		# @current_user = current_user.contacts
  	else
  		flash[:warning] = 'You must be logged in to see this page'
  		redirect_to '/login'
  	end
  end

  def new 
  end

  def update
  end

end
