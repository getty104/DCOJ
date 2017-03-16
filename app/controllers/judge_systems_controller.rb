class JudgeSystemsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_question, only: [:judge, :contest_judge, :accept, :evaluate, :wrong_answer]
	# GET /judge_systems
	# GET /judge_systems.json


	def judge
		
		result = answer_crrect?
		if result == true
			if current_user != @question.created_user && !current_user.questions.include?(@question)
				current_user.questions << @question
				num =  current_user.solved_question_number + 1
				current_user.update_attribute(:solved_question_number, num)
			end
			@record = current_user.records.build(result: "AC")
			post = current_user.posts.build(category: 1)
			@question.posts << post
			@question.records << @record
			flash.now[:success] = "Accepted!"
		elsif result == false
			@record = current_user.records.build(result: "WA")
			@question.records << @record
			flash.now[:danger] = "Wrong Answer..."
		else
			@record = current_user.records.build(result: "TLE")
			@question.records << @record
			flash.now[:danger] = "Time Limit Exceed..."
		end
		respond_to do |format|
			format.js
		end
	end

	def contest_judge
		@contest = Contest.find(params[:contest_id])
		time_up @contest

		result = answer_crrect?
		if result == true
			if current_user != @question.created_user && !current_user.questions.include?(@question)
				current_user.questions << @question
				num =  current_user.solved_question_number + 1
				current_user.update_attribute( :solved_question_number, num )
				join = Join.find_by( contest_id: @contest.id, user_id: current_user.id )
				if @question.question_level.to_i == 1
					join.update_columns( score: join.score + 100, amount_time: join.amount_time +
						(Time.now - @contest.start_time).to_i, level1_solve_time: (Time.now - @contest.start_time).to_i )
				elsif @question.question_level.to_i == 2
					join.update_columns( score: join.score + 200, amount_time: join.amount_time + 
						(Time.now - @contest.start_time).to_i, level2_solve_time: (Time.now - @contest.start_time).to_i )
				elsif @question.question_level.to_i == 3
					join.update_columns( score: join.score + 300, amount_time: join.amount_time + 
						(Time.now - @contest.start_time).to_i, level3_solve_time: (Time.now - @contest.start_time).to_i )
				elsif @question.question_level.to_i == 4
					join.update_columns( score: join.score + 400, amount_time: join.amount_time + 
						(Time.now - @contest.start_time).to_i, level4_solve_time: (Time.now - @contest.start_time).to_i )
				elsif @question.question_level.to_i == 5
					join.update_columns( score: join.score + 500, amount_time: join.amount_time + 
						(Time.now - @contest.start_time).to_i, level5_solve_time: (Time.now - @contest.start_time).to_i )
				end
				update_ranking
			end
			@record = current_user.records.build(result: "AC")
			post = current_user.posts.build(category: 1)
			@question.records << @record
			@question.posts << post
		elsif result == false
			@record = current_user.records.build(result: "WA")
			@question.records << @record
		else
			@record = current_user.records.build(result: "TLE")
			@question.records << @record
		end

		respond_to do |format|
			format.js
		end
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_question
			@question = Question.find(params[:id])
		end

		require 'timeout'
			def run(submit_code, input_file, ans_file, time )
				result_or_error = nil
				begin
					Timeout::timeout time do
						result_or_error =	system"wandbox run #{submit_code} < #{input_file} > #{ans_file}"
					end
				rescue Timeout::Error => e
					result_or_error = e
				end
				return result_or_error
			end


		def answer_crrect?
			ans_code = params[:ans]
			lang = params[:lang]
			if Rails.env == "development"
				root = "./tmp/judge"
			else
				root = "/tmp"
			end
			case lang
			when "ruby"
				extension = "rb"
			when "c"
				extension = "c"
			when "c++"
				extension = "cpp"
			when "java"
				extension = "java"
			end
			submit_code = "#{root}/#{current_user.id}_code.#{extension}"
			input_file = "#{root}/#{current_user.id}_input.txt"
			out_file = "#{root}/#{current_user.id}_output.txt"
			ans_file = "#{root}/#{current_user.id}_ans.txt"
			File.open( submit_code, "w" ) do |code|
				code.write ans_code.gsub(/\R/, "\n") 
				code.close
			end
			File.open( input_file ,"wb") do |input|
				input.write @question.input.gsub(/\R/, "\n") 
				input.close
			end
			File.open( out_file ,"wb") do |out|
				out.write @question.output.gsub(/\R/, "\n") 
				out.close
			end
			error_check = run(submit_code, input_file, ans_file, 6)
			if error_check == true
				out = File.open( out_file, "r" )
				ans = File.open( ans_file, "r" )
				return FileUtils.cmp(ans, out)
			else
				return error_check
			end
		end
	end
