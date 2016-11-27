class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by(account: params[:session][:account])

		if user && user.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to :main_menu
  else
  	flash.now[:danger] = 'Account or Password is wrong'
  	render :new
  end
end

def destroy
	log_out if logged_in?
	redirect_to root_url
end

end
