class JudgeSystemsController < ApplicationController
	before_action :set_judge_system, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!
	# GET /judge_systems
	# GET /judge_systems.json


	# GET /judge_systems/new
	def submit
		@judge_system = JudgeSystem.new
		@question = Question.find(params[:question_id])
	end


	def judge
		@question = Question.find(params[:judge_system][:question_id])
		unless params[:judge_system][:ans]
			flash.now[:danger] = '正しく提出されていません'
			render action: :new, question_id: @question.id
		else
			if answer_crrect?
				if current_user != @question.created_user && !current_user.questions.include?(@question)
					current_user.questions << @question
					num =  current_user.solved_question_number + 1
					current_user.update_attribute(:solved_question_number, num)
					@first_time = true
				end
				record = current_user.records.build(result: "AC")
				post = current_user.posts.build(category: 1)
				@question.posts << post
				current_user.save
				@question.records << record
				current_user.save
				redirect_to action: :accept, question_id: @question.id, first_time: @first_time
			else
				record = current_user.records.build(result: "WA")
				@question.records << record
				redirect_to action: :wrong_answer, question_id: @question.id
			end
		end
	end

	def contest_submit
		@contest_id = params[:contest_id]
		@contest = Contest.find(@contest_id)
		time_up @contest
		@question = Question.find(params[:question_id])
		@judge_system = JudgeSystem.new
	end

	def contest_judge
		@question = Question.find(params[:judge_system][:question_id])
		@contest = Contest.find(params[:judge_system][:contest_id])
		time_up @contest
		unless params[:judge_system][:ans]
			flash.now[:danger] = '正しく提出されていません'
			render action: :new, question_id: @question.id
		else
			if answer_crrect?
				if current_user != @question.created_user && !current_user.questions.include?(@question)
					current_user.questions << @question
					num =  current_user.solved_question_number + 1
					current_user.update_attribute( :solved_question_number, num )
					join = Join.find_by( contest_id: @contest.id, user_id: current_user.id )
					join.update_attribute( :score, join.score + @question.question_level * 100 )
					update_ranking
				end
				post = current_user.posts.build(category: 1)
				@question.posts << post
				current_user.save
				redirect_to @contest, flash: { notice: 'Accept!!!'}
			else
				redirect_to @contest, flash: {danger: 'Wrong Answer...'}
			end
		end
	end



	def accept
		@question = Question.find(params[:question_id])
		@records = current_user.records.where(question_id: @question.id).page(params[:page]).per(10).order("created_at DESC")
		@first_time = params[:first_time]
		respond_to do |format|
			format.html
			format.js
		end
	end

	def evaluate
		@question = Question.find(params[:judge_system][:question_id])
		if params[:judge_system][:first_time] && params[:judge_system][:evaluation]
			mass = @question.users.length
			data = @question.question_level*(mass-1) + params[:judge_system][:evaluation].to_i
			@question.question_level = data/mass
			@question.save
		end
		redirect_to questions_path
	end

	def wrong_answer
		@question = Question.find(params[:question_id])
		@records = current_user.records.where(question_id: @question.id).page(params[:page]).per(10).order("created_at DESC")
		respond_to do |format|
			format.html
			format.js
		end
	end




	private
		# Use callbacks to share common setup or constraints between actions.
		def set_judge_system
			@judge_system = JudgeSystem.find(params[:id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def judge_system_params
			params.require(:judge_system).permit()
		end

		def time_up contest
			redirect_to contest, flash: {danger: 'Time is up'} if Time.now >= contest.finish_time
		end

		def answer_crrect?
			ans_data = params[:judge_system][:ans].read
			File.open("/tmp/#{current_user.id}_input.txt","wb") do |ans|
				ans.write ans_data.gsub(/\R/, "\n") 
				ans.close
			end
			File.open("/tmp/#{current_user.id}_output.txt","wb") do |out|
				out.write @question.output.gsub(/\R/, "\n") 
				out.close
			end
			ans = File.open("/tmp/#{current_user.id}_input.txt", "r")
			out = File.open("/tmp/#{current_user.id}_output.txt", "r")

			return FileUtils.cmp(ans, out)
		end

		def update_ranking
			joins = @contest.joins.select(:id).order("score DESC")
			joins.each_with_index do |join, rank|
				join.update_attribute(:rank, rank + 1)
			end
		end
	end
