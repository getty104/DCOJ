class StaticPagesController < ApplicationController


	def home
		redirect_to :main_menu if user_signed_in?
	end

	def main_menu
		authenticate_user!
		@posts = Post.follows_post(current_user).includes(:question).includes(:contest).includes(:user).order(created_at: :desc).page(params[:page]).per(10)
		@created_users = User.all.select(:name, :created_question_number, :rate).limit(5).order(created_question_number: :desc)
		@solved_users = User.all.select(:name, :solved_question_number, :rate).limit(5).order(solved_question_number: :desc)
		@rate_users = User.all.select(:name, :rate).limit(5).order(rate: :desc)
		@recent_contests = current_user.contests.future_contests.select(:id,:title, :start_time).order(start_time: :desc)
		@now_contests = current_user.contests.now_contests.select(:id, :title, :start_time).limit(10).order(start_time: :desc)
	end
end
