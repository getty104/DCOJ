class QuestionsController < ApplicationController
	before_action :set_question, only: [:show, :edit, :update, :destroy, :submission,:download_input, :contest_show]
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
		@level5_questions = Question.where(question_level: 4.5...5.0, for_contest: 0).select(:id, :created_user_id, :title).includes(:created_user).includes(:users).page(params[:level5_page]).per(8).order(:id)
		@for_contest_questions = current_user.create_questions.where(for_contest: 1).select(:id, :created_user_id, :title).includes(:created_user).includes(:users).page(params[:for_contest_page]).per(8).order(:id)
		respond_to do |format|
			format.html
			format.js
		end
	end

	# GET /questions/1
	# GET /questions/1.json
	def show
		unless !@question.for_contest || current_user == @question.created_user 
			redirect_to main_menu_path
		end
	end

	def contest_show
		@contest_id = params[:contest_id]
		@contest = Contest.find(@contest_id)
#コンテスト参加者以外参加できないようにする
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

		respond_to do |format|
			if @question.save
				post = current_user.posts.build(category: 0)
				@question.posts << post
				post.save
				num =  current_user.created_question_number + 1
				current_user.update_attribute(:created_question_number, num)
				format.html { redirect_to @question, notice: 'Question was successfully created.' }
				format.json { render :show, status: :created, location: @question }
			else
				format.html { render :new }
				format.json { render json: @question.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /questions/1
	# PATCH/PUT /questions/1.json
	def update
		@question.input = params[:question][:i_data].read if params[:question][:i_data]
		@question.output = params[:question][:o_data].read if params[:question][:o_data]

		respond_to do |format|
			if @question.update(question_params)
				format.html { redirect_to @question, notice: 'Question was successfully updated.' }
				format.json { render :show, status: :ok, location: @question }
			else
				format.html { render :edit }
				format.json { render json: @question.errors, status: :unprocessable_entity }
			end
		end
	end

	def download_input
		send_data(
			@question.input,
			type: 'text/txt; charset=utf-8;',
			disposition: 'attachment',
			filename: "#{@question.id}_input.txt",
			status: 200
			)
	end

	# DELETE /questions/1
	# DELETE /questions/1.json
	def destroy
		@question.destroy
		num =  current_user.created_question_number - 1
		current_user.update_attribute(:created_question_number, num)
		respond_to do |format|
			format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_question
			@question = Question.find(params[:id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def question_params
			params.require(:question).permit(:title, :content,:question_id, :input, :output, :i_data, 
				:o_data, :question_level, :input_text, :output_text, :sample_input, :sample_output, :image, :for_contest)
		end
end
