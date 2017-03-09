class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :request_path
	
	def request_path
		@path = controller_path + '#' + action_name
		def @path.is(*str)
			str.map{|s| self.include?(s)}.include?(true)
		end
	end

	def update_ranking
		joins = @contest.joins.select(:id, :score, :amount_time).order("score DESC, amount_time")
		rank = 0
		number = 1
		joins.size.times do |key|
			if key == 0
				rank += number
			elsif key > 0
				if joins[key].score == joins[key - 1].score && joins[key].amount_time == joins[key - 1].amount_time
					number += 1
				else
					rank += number
					number = 1
				end
			end
			joins[key].update_columns(rank: rank)
		end
	end

	def time_up contest
		redirect_to contest if Time.now >= contest.finish_time
	end

	protected
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :account, :email, :image, :created_question_number, :solved_question_number])
		devise_parameter_sanitizer.permit(:account_update, keys: [:name, :account, :image])
		devise_parameter_sanitizer.permit(:sign_in, keys: [:login, :account, :email, :password, :remember_me])
	end
end
