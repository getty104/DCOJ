require "#{Rails.root}/lib/rank_system.rb"
class ContestsController < ApplicationController
	before_action :set_contest, only: [:show, :edit, :join, :unjoin, :sync_ranking]
	before_action :set_questions_by_origin_legel, only: [:show, :sync_ranking]
	before_action :authenticate_user!
	
	def new
		@contest = Contest.new
		set_questions_for_new
	end

	def create
		@contest = current_user.create_contests.build(contest_params)
		@contest.finish_time = @contest.start_time + params[:contest][:contest_length].to_i.hours
		if @contest.save
			post = current_user.posts.build(category: 3)
			@contest.posts << post
			current_user.save
			question1 = Question.find(params[:contest][:level1_question]) unless params[:contest][:level1_question].blank?
			question2 = Question.find(params[:contest][:level2_question]) unless params[:contest][:level2_question].blank?
			question3 = Question.find(params[:contest][:level3_question]) unless params[:contest][:level3_question].blank?
			question4 = Question.find(params[:contest][:level4_question]) unless params[:contest][:level4_question].blank?
			question5 = Question.find(params[:contest][:level5_question]) unless params[:contest][:level5_question].blank?
			question1.update_attribute(:for_contest, 2) if question1
			question2.update_attribute(:for_contest, 2) if question2
			question3.update_attribute(:for_contest, 2) if question3
			question4.update_attribute(:for_contest, 2) if question4
			question5.update_attribute(:for_contest, 2) if question5
			@contest.questions << question1 if question1
			@contest.questions << question2 if question2
			@contest.questions << question3 if question3
			@contest.questions << question4 if question4
			@contest.questions << question5 if question5
			@contest.save
			redirect_to @contest, flash: { notice: 'Contest was successfully created.' }
		else
			set_questions_for_new
			render :new 
		end
	end



	def show
		set_questions_by_origin_legel
		set_contest_joins
		@questions = @contest.questions.order(:origin_level)
		move_questions	if @contest.end? && @contest.contest_end != true
	end

	def sync_ranking
		set_contest_joins
		respond_to do |format|
			format.js
		end
	end

	def index
		@now_contests = Contest.now_contests.select(:id, :start_time, :finish_time, :title, :description, :created_user_id ).includes(:created_user).page(params[:now_contest_page]).per(8)
		@end_contests = Contest.end_contests.select(:id, :start_time, :finish_time, :title, :description, :created_user_id ).includes(:created_user).page(params[:end_contest_page]).per(8)
		@future_contests =  Contest.future_contests.select(:id, :start_time, :finish_time, :title, :description, :created_user_id ).includes(:created_user).page(params[:future_contest_page]).per(8)
	end

	def edit
	end

	def update
	end

	def destroy
	end

	def join
		@user = User.find_by(account: params[:join_account])
		@contest.users << @user 
		post = current_user.posts.build(category: 2)
		@contest.posts << post
		current_user.save
		RankSystem.update_ranking(@contest)
		redirect_to @contest
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_contest
			@contest = Contest.find(params[:id])
		end

		def set_questions_for_new
			@level1_questions = current_user.create_questions.for_contest.level_questoins(1).select(:id, :created_user_id, :title, :for_contest, :question_level)
			@level2_questions = current_user.create_questions.for_contest.level_questoins(2).select(:id, :created_user_id, :title, :for_contest, :question_level)
			@level3_questions = current_user.create_questions.for_contest.level_questoins(3).select(:id, :created_user_id, :title, :for_contest, :question_level)
			@level4_questions = current_user.create_questions.for_contest.level_questoins(4).select(:id, :created_user_id, :title, :for_contest, :question_level)
			@level5_questions = current_user.create_questions.for_contest.level_questoins(5).select(:id, :created_user_id, :title, :for_contest, :question_level)
		end

		def set_questions_by_origin_legel
			@question1 = @contest.questions.select(:id).find_by(origin_level: 1)
			@question2 = @contest.questions.select(:id).find_by(origin_level: 2)
			@question3 = @contest.questions.select(:id).find_by(origin_level: 3)
			@question4 = @contest.questions.select(:id).find_by(origin_level: 4)
			@question5 = @contest.questions.select(:id).find_by(origin_level: 5)
		end

		def set_contest_joins
			@joins = @contest.joins.order(rank: :asc).includes(:user).page(params[:page]).per(20)
			@current_join = @contest.joins.find_by(user_id: current_user.id)
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def contest_params
			params.require(:contest).permit(:title, :start_time, :finish_time, :description)
		end

		def move_questions
			@contest.questions.each do |question|
				question.update_attribute(:for_contest, 0)
			end
		end
	end
