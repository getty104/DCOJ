class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?


  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :account, :email, :image, :created_question_number, :solved_question_number])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :account, :image])
     devise_parameter_sanitizer.permit(:sign_in, keys: [:login, :account, :email, :password, :remember_me])
  end
end
