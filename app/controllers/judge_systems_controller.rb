require "#{Rails.root}/lib/sand_box.rb"
require "#{Rails.root}/lib/rank_system.rb"
class JudgeSystemsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_question, only: [:judge, :contest_judge ]
	before_action :set_contest, only: [:contest_judge]
	# GET /judge_systems
	# GET /judge_systems.json


	def judge
		result = answer_crrect?
		if result == true
			if first_time?
				update_solved_data
			end
			update_record("AC")
			update_post
			flash.now[:notice] = "Accepted!"
		elsif result == false
			update_record("WA")
			flash.now[:danger] = "Wrong Answer..."
		elsif result == 'TLE'
			update_record("TLE")
			flash.now[:danger] = "Time Limit Exceed..."
		elsif result == 'RE'
			update_record("RE")
			flash.now[:danger] = "Run Time Error..."
		end
		respond_to do |format|
			format.js
		end
	end

	def contest_judge
		time_up @contest
		result = answer_crrect?
		if result == true
			if first_time?
				update_solved_data
				join = Join.find_by( contest_id: @contest.id, user_id: current_user.id )
				case @question.question_level.to_i
				when 1
					join.update_columns( score: join.score + 100, amount_time: join.amount_time +
						(Time.now - @contest.start_time).to_i, level1_solve_time: (Time.now - @contest.start_time).to_i )
				when 2
					join.update_columns( score: join.score + 200, amount_time: join.amount_time + 
						(Time.now - @contest.start_time).to_i, level2_solve_time: (Time.now - @contest.start_time).to_i )
				when 3
					join.update_columns( score: join.score + 300, amount_time: join.amount_time + 
						(Time.now - @contest.start_time).to_i, level3_solve_time: (Time.now - @contest.start_time).to_i )
				when 4
					join.update_columns( score: join.score + 400, amount_time: join.amount_time + 
						(Time.now - @contest.start_time).to_i, level4_solve_time: (Time.now - @contest.start_time).to_i )
				when 5
					join.update_columns( score: join.score + 500, amount_time: join.amount_time + 
						(Time.now - @contest.start_time).to_i, level5_solve_time: (Time.now - @contest.start_time).to_i )
				end
				RankSystem.update_ranking(@contest)
			end
			update_record("AC")
			update_post
			flash.now[:notice] = "Accepted!"
		elsif result == false
			update_record("WA")
			flash.now[:danger] = "Wrong Answer..."
		elsif result == 'TLE'
			update_record("TLE")
			flash.now[:danger] = "Time Limit Exceed..."
		elsif result == 'RE'
			update_record("RE")
			flash.now[:danger] = "Run Time Error..."
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

		def set_contest
			@contest = Contest.find(params[:contest_id])
		end

		def update_solved_data
			current_user.questions << @question
			num =  current_user.solved_question_number + 1
			current_user.update_attribute( :solved_question_number, num )
		end

		def update_record(result)
			@record = current_user.records.build(result: result )
			@question.records << @record
		end

		def update_post
			post = current_user.posts.build(category: 1)
			@question.posts << post
		end

		def first_time?
			current_user != @question.created_user && !current_user.questions.include?(@question)
		end

		def answer_crrect?
			ans_code = params[:ans].to_s.gsub(/\R/, "\n") 
			lang = params[:lang].to_s

			ans_out = Wandbox.run( lang, ans_code, @question.input, 5)
			if ans_out == 'TLE'
				return 'TLE'
			elsif ans_out == 'RE'
				return 'RE'
			else
				return ans_out == @question.output
			end
		end
	end
