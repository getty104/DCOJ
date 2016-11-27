class JudgeSystemsController < ApplicationController
  before_action :set_judge_system, only: [:show, :edit, :update, :destroy]

  # GET /judge_systems
  # GET /judge_systems.json


  # GET /judge_systems/new
  def new
    @judge_system = JudgeSystem.new
  end


  def create
    #@judge_system = JudgeSystem.new(judge_system_params)
    @question = Question.find(params[:judge_system][:question_id])
    #answer = File.open("#{params[:judge_system][:file].read}","r").read
    
    answer = params[:judge_system][:ans]
    output = File.open("app/assets/questions/output/#{@question.id}_output.txt","r").read
    if answer == output
      current_user.codes << Code.create(:question_number => @question.id) 
      redirect_to :action => :AC 
    else
     redirect_to :action => :WA
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
      params.require(:judge_system).permit(:new, :create)
    end
  end
