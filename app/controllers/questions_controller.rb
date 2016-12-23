class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy, :submission,:download_input]

  # GET /questions
  # GET /questions.json



  def search_result
   @questions = Question.search(params[:search]).page(params[:page]).per(10).order(:id)
 end

 def index
  @level1_questions = Question.where(question_level: 1...2).page(params[:level1_page]).per(8).order(:id)
  @level2_questions = Question.where(question_level: 2...3).page(params[:level2_page]).per(8).order(:id)
  @level3_questions = Question.where(question_level: 3...4).page(params[:level3_page]).per(8).order(:id)
  @level4_questions = Question.where(question_level: 4...5).page(params[:level4_page]).per(8).order(:id)
  @level5_questions = Question.where(question_level: 5).page(params[:level5_page]).per(8).order(:id)

  respond_to do |format|
    format.html
    format.js
  end
end

  # GET /questions/1
  # GET /questions/1.json
  def show
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
        current_user.created_question_number += 1
        current_user.save
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
   if params[:question][:i_data]
    @question.input = params[:question][:i_data].read
  end
  
  if params[:question][:o_data]
    @question.output = params[:question][:o_data].read
  end
  
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
    current_user.created_question_number -= 1
    current_user.save
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
      params.require(:question).permit(:title, :content,:question_id, :input, :output,:i_data, :o_data,:question_level)
    end
  end
