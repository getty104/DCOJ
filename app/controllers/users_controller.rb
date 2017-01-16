class UsersController < ApplicationController
	before_action :set_user, only: [:show, :follower_list, :following_list]
	before_action :authenticate_user!
	# GET /users/1
	# GET /users/1.json
	def show
		redirect_to main_menu_path if @user.blocking?(current_user)
		@records = @user.records.page(params[:records_page]).per(5).order("created_at DESC")
		@create_questions = @user.create_questions.includes(:created_user).includes(:users).page(params[:create_questions_page]).select(:id, :title, :created_user_id, :question_level).per(5).order(:id)
		@solve_questions = @user.questions.includes(:created_user).includes(:uers).page(params[:solve_questions_page]).select(:id, :title, :created_user_id, :question_level).per(5).order(:id)
		respond_to do |format|
			format.html
			format.js
		end
	end

	def do_follow
		@user = User.find_by(account: params[:follow_account])
		current_user.follow @user 
		redirect_to @user
	end

	def do_unfollow
		@user = User.find_by(account: params[:follow_account])
		current_user.unfollow @user
		redirect_to @user
	end

	def do_block
		@user = User.find_by(account: params[:block_account])
		current_user.block @user 
		redirect_to @user
	end

	def do_unblock
		@user = User.find_by(account: params[:block_account])
		current_user.unblock @user
		redirect_to @user
	end

	def follower_list
		@users = @user.followers.select(:id,:name, :image).order(:id).page(params[:page]).per(6)
	end

	def following_list
		@users = @user.following.select(:id, :name, :image).order(:id).page(params[:page]).per(6)
	end

	def search_result
		@users = User.search(params[:search]).select(:id, :name, :image).page(params[:page]).per(6)
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_user
			@user = User.find_by(name: params[:name])
		end
end