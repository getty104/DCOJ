class ContestsController < ApplicationController
	before_action :set_contest, only: [:show, :edit, :join, :unjoin]
	before_action :authenticate_user!
	
	def new
		@contest = Contest.new
		@level1_questions = Question.where(question_level: 1.0...1.5, for_contest: 1).select(:id, :created_user_id, :title, :for_contest, :question_level)
		@level2_questions = Question.where(question_level: 1.5...2.5, for_contest: 1).select(:id, :created_user_id, :title, :for_contest, :question_level)
		@level3_questions = Question.where(question_level: 2.5...3.5, for_contest: 1).select(:id, :created_user_id, :title, :for_contest, :question_level)
		@level4_questions = Question.where(question_level: 3.5...4.5, for_contest: 1).select(:id, :created_user_id, :title, :for_contest, :question_level)
		@level5_questions = Question.where(question_level: 4.5...5.0, for_contest: 1).select(:id, :created_user_id, :title, :for_contest, :question_level)
	end

	def create
		@contest = current_user.create_contests.build(contest_params)
		@contest.finish_time = @contest.start_time + params[:contest][:contest_length].to_i.hours
		respond_to do |format|
			if @contest.save
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
				format.html { redirect_to @contest, notice: 'Contest was successfully created.' }
				format.json { render :show, status: :created, location: @contest }
			else
				format.html { render :new }
				format.json { render json: @contest, status: :unprocessable_entity }
			end
		end
	end



	def show
		@questions = @contest.questions.order(:question_level)
		@joins = @contest.joins.order("score DESC").includes(:user)
	end

	def index
		@contests = Contest.where( contest_end: false ).order("start_time DESC").select(:id, :start_time, :finish_time, :title, :description, :created_user_id ).includes(:created_user).page(params[:page]).per(8)
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
		redirect_to @contest
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_contest
			@contest = Contest.find(params[:id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def contest_params
			params.require(:contest).permit(:title, :start_time, :finish_time, :description)
		end
		
	end
