class UsersController < ApplicationController
	before_action :set_user, only: [:show, :follower_list, :following_list]
	before_action :authenticate_user!
	# GET /users/1
	# GET /users/1.json
	def show
		not_found if @user.blocking?(current_user)
		@records = @user.records.order(created_at: :desc).page(params[:records_page]).per(5)
		@create_questions = @user.create_questions.for_public.includes(:created_user).includes(:users).select(:id, :title, :created_user_id, :question_level).order(:id).page(params[:create_questions_page]).per(5)
		@solve_questions = @user.questions.for_public.includes(:created_user).includes(:users).select(:id, :title, :created_user_id, :question_level).order(:id).page(params[:solve_questions_page]).per(5)
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
		@users = @user.followers.select(:id,:name, :image).order(:id).page(params[:page]).per(12)
	end

	def following_list
		@users = @user.following.select(:id, :name, :image).order(:id).page(params[:page]).per(12)
	end

	def search_result
		@users = User.search(params[:search]).select(:id, :name, :image).page(params[:page]).per(12)
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_user
			@user = User.find_by(name: params[:name])
		end
end