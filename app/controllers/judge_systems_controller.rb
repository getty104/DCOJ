require "#{Rails.root}/lib/sand_box.rb"
require "#{Rails.root}/lib/rank_system.rb"
require "judge_system"
class JudgeSystemsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_question, only: [:judge, :contest_judge ]
	before_action :set_contest, only: [:contest_judge]
	# GET /judge_systems
	# GET /judge_systems.json


	def judge
		respond_to do |format|
		format.html{ not_found }

		submitted_code = params[:ans].to_s.gsub(/\R/, "\n") 
		lang = params[:lang].to_s
		result = JudgeSystem.judge_result lang: lang, code: submitted_code, answer: @question.output, stdin: @question.input, time: 20
		case result
		when 'AC'
			if first_time?
				update_solved_data
			end
			update_record("AC")
			update_post
			flash.now[:notice] = "Accepted!"
		when 'WA'
			update_record("WA")
			flash.now[:danger] = "Wrong Answer..."
		when 'TLE'
			update_record("TLE")
			flash.now[:danger] = "Time Limit Exceed..."
		when 'RE'
			update_record("RE")
			flash.now[:danger] = "Run Time Error..."
		end
			format.js
		end
	end

	def contest_judge
		respond_to do |format|
		format.html{ not_found }

		submitted_code = params[:ans].to_s.gsub(/\R/, "\n") 
		lang = params[:lang].to_s
		result = JudgeSystem.judge_result lang: lang, code: submitted_code, answer: @question.output, stdin: @question.input, time: 20
		case result
		when 'AC'
			if first_time?
				update_solved_data
				case @question.original_level.to_i
				when 1
					update_status 1
				when 2
					update_status 2
				when 3
					update_status 3
				when 4
					update_status 4
				when 5
					update_status 5
				end
				RankSystem.update_ranking(@contest)
			end
			update_record("AC")
			update_post
			flash.now[:notice] = "Accepted!"
		when 'WA'
			update_record("WA")
			flash.now[:danger] = "Wrong Answer..."
		when 'TLE'
			update_record("TLE")
			flash.now[:danger] = "Time Limit Exceed..."
		when 'RE'
			update_record("RE")
			flash.now[:danger] = "Run Time Error..."
		end
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

		def update_status question_level
		solve_time = "level#{question_level}_solve_time"
		@join = Join.find_by( contest_id: @contest.id, user_id: current_user.id )
		@join.update_attributes( score: score + 100 * question_level, amount_time: amount_time +
			(Time.now - contest.start_time).to_i, solve_time => (Time.now - contest.start_time).to_i )
	  end

	end
