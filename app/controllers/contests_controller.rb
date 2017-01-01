class ContestsController < ApplicationController
  before_action :authenticate_user!
  def new
    @contest = Contest.new
  end

  def create
  end

  def index
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contest
      @question = Contest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contest_params
      params.require(:contest).permit(:title, :start_time, :finish_time)
    end
    
  end
