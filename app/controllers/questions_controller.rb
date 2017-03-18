class QuestionsController < ApplicationController
	before_action :set_question, only: [:show, :edit, :update, :destroy, :submission,:download_input, :contest_show]
	before_action :set_contest, only: [:contest_show]
	before_action :authenticate_user!
	# GET /questions
	# GET /questions.json

	def search_result
		@questions = Question.search(params[:search]).select(:id, :created_user_id, :title).includes(:created_user).includes(:users).page(params[:page]).per(10).order(:id)
	end

	def index
		@level1_questions = Question.where(question_level: 1.0...1.5, for_contest: 0).select(:id, :created_user_id, :title).includes(:created_user).includes(:users).page(params[:level1_page]).per(8).order(:id)
		@level2_questions = Question.where(question_level: 1.5...2.5, for_contest: 0).select(:id, :created_user_id, :title).includes(:created_user).includes(:users).page(params[:level2_page]).per(8).order(:id)
		@level3_questions = Question.where(question_level: 2.5...3.5, for_contest: 0).select(:id, :created_user_id, :title).includes(:created_user).includes(:users).page(params[:level3_page]).per(8).order(:id)
		@level4_questions = Question.where(question_level: 3.5...4.5, for_contest: 0).select(:id, :created_user_id, :title).includes(:created_user).includes(:users).page(params[:level4_page]).per(8).order(:id)
		@level5_questions = Question.where(question_level: 4.5...5.1, for_contest: 0).select(:id, :created_user_id, :title).includes(:created_user).includes(:users).page(params[:level5_page]).per(8).order(:id)
		@for_contest_questions = current_user.create_questions.where(for_contest: 1).select(:id, :created_user_id, :title).includes(:created_user).includes(:users).page(params[:for_contest_page]).per(8).order(:id)
		respond_to do |format|
			format.html
			format.js
		end
	end

	# GET /questions/1
	# GET /questions/1.json
	def show
		render file: "#{Rails.root}/public/404.html", status: 404	unless @question.for_contest == 0 || current_user == @question.created_user
		@records = current_user.records.where(question_id: @question.id).limit(20).order("created_at DESC")
	end

	def contest_show
		if @contest.users.include?(current_user)
			time_up @contest
		else
			render file: "#{Rails.root}/public/404.html", status: 404	
		end
		@records = current_user.records.where(question_id: @question.id).limit(20).order("created_at DESC")
	end

	# GET /questions/new
	def new
		@question = Question.new
	end

	# GET /questions/1/edit
	def edit
		if current_user != @question.created_user
			redirect_to @question
		end
	end

	# POST /questions
	# POST /questions.json
	def create
		@question = current_user.create_questions.build(question_params)
		@question.input = params[:question][:i_data].read if params[:question][:i_data]
		@question.output = params[:question][:o_data].read if params[:question][:o_data]
		@question.origin_level =  params[:question][:question_level].to_i
		if @question.save
			post = current_user.posts.build(category: 0)
			@question.posts << post
			current_user.save
			num =  current_user.created_question_number + 1
			current_user.update_attribute(:created_question_number, num)
			redirect_to @question, flash: { notice: 'Question was successfully created.' }
		else
			render :new
		end
	end

	# PATCH/PUT /questions/1
	# PATCH/PUT /questions/1.json
	def update
		@question.input = params[:question][:i_data].read if params[:question][:i_data]
		@question.output = params[:question][:o_data].read if params[:question][:o_data]

		if @question.update(question_params)
			redirect_to @question, flash: {notice: 'Question was successfully updated.' }
		else
			render :edit 
		end
	end


	# DELETE /questions/1
	# DELETE /questions/1.json
	def destroy
		@question.destroy
		num =  current_user.created_question_number - 1
		current_user.update_attribute(:created_question_number, num)
		redirect_to questions_url, flash: {notice: 'Question was successfully destroyed.' }
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_question
			@question = Question.find(params[:id])
		end

		def set_contest
			@contest = Contest.find(params[:contest_id])
		end


		# Never trust parameters from the scary internet, only allow the white list through.
		def question_params
			params.require(:question).permit(:title, :content,:question_id, :input, :output, :i_data, 
				:o_data, :question_level, :input_text, :output_text, :sample_input, :sample_output, :image, :for_contest)
		end
	end
