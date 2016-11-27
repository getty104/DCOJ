class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy, :submission,:download]

  # GET /questions
  # GET /questions.json





  def index
    @questions = Question.all
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
    if current_user.id != @question.user_id
      redirect_to @question
    end
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    @question.input = params[:question][:input].read
    @question.output = params[:question][:output].read
    respond_to do |format|
      if @question.save
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
    respond_to do |format|
      if @question.update(question_params)
       @question.input = params[:question][:input].read
       @question.output = params[:question][:output].read
       format.html { redirect_to @question, notice: 'Question was successfully updated.' }
       format.json { render :show, status: :ok, location: @question }
     else
      format.html { render :edit }
      format.json { render json: @question.errors, status: :unprocessable_entity }
    end
  end
end

def download
  File.open("app/assets/questions/input/input.txt","wb") do |file|
    file.write(@question.input)
    file.close
  end
  @filepath = "app/assets/questions/input/input.txt"
  send_file(@filepath,
   :type => 'text/txt',
   :disposition => 'attachment',
   :filename => "#{@question.id}_input.txt",
   :status => 200)
end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
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
      params.require(:question).permit(:title, :content,:question_id, :input, :output)
    end
  end
