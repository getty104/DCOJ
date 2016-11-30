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
        redirect_to :action => :AC 
      else
       redirect_to :action => :WA
     end
   end
 end

 def AC
 end

 def WA
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
