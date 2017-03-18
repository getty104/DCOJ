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

	def time_up contest
		redirect_to contest_path(contest) if contest.end?
	end

	def not_found
		render file: "#{Rails.root}/public/404.html", status: 404
	end

	protected
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :account, :email, :image, :created_question_number, :solved_question_number])
		devise_parameter_sanitizer.permit(:account_update, keys: [:name, :account, :image])
		devise_parameter_sanitizer.permit(:sign_in, keys: [:login, :account, :email, :password, :remember_me])
	end
end
