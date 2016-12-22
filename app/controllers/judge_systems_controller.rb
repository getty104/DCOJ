class JudgeSystemsController < ApplicationController
  before_action :set_judge_system, only: [:show, :edit, :update, :destroy]

  # GET /judge_systems
  # GET /judge_systems.json


  # GET /judge_systems/new
  def new
    @judge_system = JudgeSystem.new
    @question = Question.find(params[:question_id])
  end


  def create
    if !params[:judge_system][:ans]
      flash.now[:danger] = '正しく提出されていません'
      render :new
    else
      @question = Question.find(params[:judge_system][:question_id])
      ans_data = params[:judge_system][:ans].read
      if ans_data == @question.output
        if current_user != @question.created_user && !current_user.questions.include?(@question)
          current_user.questions << @question
          current_user.solved_question_number += 1
          @first_time = true
        end
        record = current_user.records.build(result: "AC")
        post = current_user.posts.build(category: 1)
        @question.posts << post
        post.save
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

 

 def accept
  @question = Question.find(params[:question_id])
  @records = @question.records.page(params[:page]).per(10).order("created_at DESC")
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
 @records = @question.records.page(params[:page]).per(10).order("created_at DESC")
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
  end
