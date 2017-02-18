class StaticPagesController < ApplicationController


	def home
		redirect_to :main_menu if user_signed_in?
	end

	def main_menu
		authenticate_user!
		@posts = Post.order("created_at DESC").includes(:user).includes(:question).page(params[:page]).per(10)
		@created_users = User.all.select(:name, :created_question_number).limit(5).order('created_question_number DESC')
		@solved_users = User.all.select(:name, :solved_question_number).limit(5).order('solved_question_number DESC')
		@recent_contests = current_user.contests.where("start_time > ?", Time.now).select(:id,:title, :start_time).order('start_time DESC')
		@now_contests = current_user.contests.where("start_time < ?", Time.now).where("finish_time > ?", Time.now).select(:id, :title, :start_time).limit(10).order('start_time DESC')
		respond_to do |format|
			format.html
			format.js
		end
	end
end
