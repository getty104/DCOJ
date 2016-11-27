class JudgeSystemsController < ApplicationController
  before_action :set_judge_system, only: [:show, :edit, :update, :destroy]

  # GET /judge_systems
  # GET /judge_systems.json


  # GET /judge_systems/new
  def new
    @judge_system = JudgeSystem.new
  end


  def create
    @question = Question.find(params[:judge_system][:question_id])
    ans_name = "#{current_user.id}_ans.txt"
    ans_data = params[:judge_system][:ans].read
    File.open("app/assets/questions/answer/#{ans_name}","wb") do |ans|
      ans.write ans_data
      ans.close
    end
    output_name = "#{current_user.id}_output.txt"
    output_data =@question.output
     File.open("app/assets/questions/output/#{output_name}","wb") do |output|
      output.write output_data
      output.close
    end
    answer =  File.open("app/assets/questions/answer/#{ans_name}","r")
    output = File.open("app/assets/questions/output/#{output_name}","r")
    if FileUtils.cmp(answer, output) 
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
