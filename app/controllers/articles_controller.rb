class ArticlesController < ApplicationController

	# load_and_authorize_resource

	before_action :set_article, only: [:show, :edit, :update, :delete]

	def index
		@articles = Article.order('created_at desc')
	end

	def create
		begin 
			@article = current_user.articles.create!(article_params)
			redirect_to articles_path
		rescue StandardError => e
			flash[:message] = e.message
			render :new
		end
	end

	def new
		@article = Article.new
	end

	def show

	end

	def update
		if @article.update_attributes(article_params)
			redirect_to articles_path(@article)
		else
			render :edit
		end
	end

	def edit 
	end

	def destroy
		@article.destroy
		redirect_to articles_path
	end

	private 

	def article_params
		params.require(:article).permit(:author, :name, :description)
	end

	def set_article
		@article = current_user.articles.find_by(id: params[:id])
	end
end
