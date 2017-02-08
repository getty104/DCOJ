class ContestsController < ApplicationController
	before_action :authenticate_user!
	
	def new
		@contest = Contest.new
	end

	def create
		@contest = Contest.new(contest_params)
		
		respond_to do |format|
			if @contest.save
				format.html { redirect_to @contest, notice: 'Contest was successfully created.' }
				format.json { render :show, status: :created, location: @contest }
			else
				format.html { render :new }
				format.json { render json: @contest, status: :unprocessable_entity }
			end
		end
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
