class ContestsController < ApplicationController
	before_action :set_contest, only: [:show, :edit, :join, :unjoin, :sync_ranking]
	before_action :authenticate_user!
	
	def new
		@contest = Contest.new
		@level1_questions = current_user.create_questions.where(question_level: 1.0...1.5, for_contest: 1).select(:id, :created_user_id, :title, :for_contest, :question_level)
		@level2_questions = current_user.create_questions.where(question_level: 1.5...2.5, for_contest: 1).select(:id, :created_user_id, :title, :for_contest, :question_level)
		@level3_questions = current_user.create_questions.where(question_level: 2.5...3.5, for_contest: 1).select(:id, :created_user_id, :title, :for_contest, :question_level)
		@level4_questions = current_user.create_questions.where(question_level: 3.5...4.5, for_contest: 1).select(:id, :created_user_id, :title, :for_contest, :question_level)
		@level5_questions = current_user.create_questions.where(question_level: 4.5...5.0, for_contest: 1).select(:id, :created_user_id, :title, :for_contest, :question_level)
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
			@level1_questions = current_user.create_questions.where(question_level: 1.0...1.5, for_contest: 1).select(:id, :created_user_id, :title, :for_contest, :question_level)
			@level2_questions = current_user.create_questions.where(question_level: 1.5...2.5, for_contest: 1).select(:id, :created_user_id, :title, :for_contest, :question_level)
			@level3_questions = current_user.create_questions.where(question_level: 2.5...3.5, for_contest: 1).select(:id, :created_user_id, :title, :for_contest, :question_level)
			@level4_questions = current_user.create_questions.where(question_level: 3.5...4.5, for_contest: 1).select(:id, :created_user_id, :title, :for_contest, :question_level)
			@level5_questions = current_user.create_questions.where(question_level: 4.5...5.0, for_contest: 1).select(:id, :created_user_id, :title, :for_contest, :question_level)
			render :new 
		end
	end



	def show
		@questions = @contest.questions.order(:origin_level)
		@question1 = @contest.questions.select(:id).find_by(origin_level: 1)
		@question2 = @contest.questions.select(:id).find_by(origin_level: 2)
		@question3 = @contest.questions.select(:id).find_by(origin_level: 3)
		@question4 = @contest.questions.select(:id).find_by(origin_level: 4)
		@question5 = @contest.questions.select(:id).find_by(origin_level: 5)
		@joins = @contest.joins
		.select(:id,:user_id,:rank,:score, :updated_at, :level1_solve_time, :level2_solve_time, :level3_solve_time, :level4_solve_time, :level5_solve_time, :amount_time)
		.order("score DESC, amount_time").includes(:user).page(params[:page]).per(20)
		@current_join = @contest.joins
		.select(:id,:user_id,:rank,:score, :updated_at, :level1_solve_time, :level2_solve_time, :level3_solve_time, :level4_solve_time, :level5_solve_time, :amount_time)
		.find_by(user_id: current_user.id)
		update_info	if @contest.finish_time <= Time.now && @contest.contest_end == false
	end

	def sync_ranking
		@question1 = @contest.questions.select(:id).find_by(origin_level: 1)
		@question2 = @contest.questions.select(:id).find_by(origin_level: 2)
		@question3 = @contest.questions.select(:id).find_by(origin_level: 3)
		@question4 = @contest.questions.select(:id).find_by(origin_level: 4)
		@question5 = @contest.questions.select(:id).find_by(origin_level: 5)
		@joins = @contest.joins
		.select(:id,:user_id,:rank,:score, :level1_solve_time, :level2_solve_time, :level3_solve_time, :level4_solve_time, :level5_solve_time, :amount_time)
		.order("score DESC, amount_time").includes(:user).page(params[:page]).per(20)
		@current_join = @contest.joins
		.select(:id,:user_id,:rank,:score, :level1_solve_time, :level2_solve_time, :level3_solve_time, :level4_solve_time, :level5_solve_time, :amount_time)
		.find_by(user_id: current_user.id)
		respond_to do |format|
			format.js
		end
	end

	def index
		@now_contests = Contest.now_contests.order("start_time DESC").select(:id, :start_time, :finish_time, :title, :description, :created_user_id ).includes(:created_user).page(params[:now_contest_page]).per(8)
		@end_contests = Contest.end_contests.order("start_time DESC").select(:id, :start_time, :finish_time, :title, :description, :created_user_id ).includes(:created_user).page(params[:end_contest_page]).per(8)
		@future_contests =  Contest.future_contests.order("start_time DESC").select(:id, :start_time, :finish_time, :title, :description, :created_user_id ).includes(:created_user).page(params[:future_contest_page]).per(8)
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
		update_ranking
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

		def update_info
			change_rating
			@contest.questions.each do |question|
				question.update_attribute(:for_contest, 0)
			end
			@contest.update_attribute(:contest_end, true)
		end

		def arc_gauss(x)
			return (-0.5*(Math.log(1-x**2)))**(Math.PI/2)
		end

		def change_rating
			averating=0
			joins = @contest.joins.includes(:user)
			numofcoder = joins.size.to_i
			averating = 0
			joins.each do |join|
				averating += join.user.rate
			end
			averating /= numofcoder

			competition_factor_sum1, competition_factor_sum2 = 0, 0
			joins.each do |join|
				competition_factor_sum1 += join.user.volatility**2
				competition_factor_sum2 +=(join.user.rate - averating)**2
			end
			competition_factor = (competition_factor_sum1/numofcoder + competition_factor_sum2/(numofcoder - 1))**0.5

			newrate = []
			newvolatility = []
			numofcoder.times do |key1|
				erank=0.5
				oldrate = joins[key1].user.rate
				oldvolatility = joins[key1].user.volatility

				numofcoder.times do |key2|
					erank+=0.5*(Math.erf((oldrate - joins[key2].user.rate)/((2*(oldvolatility**2 + joins[key2].user.volatility**2))**0.5))+1)
				end

				eperf = - arc_gauss((erank - 0.5)/numofcoder)
				aperf = - arc_gauss((joins[key1].rank - 0.5)/numofcoder)
				perfas = joins[key1].user.rate + competition_factor*(aperf-eperf)
				weight = (1/(1 - ((0.42/(joins[key1].user.joins.size.to_i + 1)) + 0.18)))-1
				capacity = 150 + 1500/(joins[key1].user.joins.size.to_i + 2)
				newrate << (oldrate + weight*perfas)/(1 + weight)
				newvolatility << ((newrate[key1] - oldrate)**2/weight + oldvolatility**2/(weight + 1))**0.5
			end
			numofcoder.times do |key|
				joins[key].user.update_columns(rate: nowrate[key],volatility: newvolatility[key])
			end
		end
	end
