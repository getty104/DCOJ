Rails.application.routes.draw do

	mathjax 'mathjax'
	root 'static_pages#home'
	get 'home'    => 'static_pages#home'
	get 'main_menu' => 'static_pages#main_menu'
	get 'search_result' => 'questions#search_result'
	get 'user_search_result' => 'users#search_result'
	get 'rate_ranking' => 'rankings#rate_ranking'
	
	resources :questions do
		member do 
			get   'download_input' 
			post 'submission' => 'judge_systems#judge'
			get 'accept' => 'judge_systems#accept'
			post 'accept' => 'judge_systems#evaluate'
			get 'wrong_answer' => 'judge_systems#wrong_answer'
		end
	end

	devise_for :users do
		get '/users/sign_out' => 'devise/sessions#destroy'
	end

	resources :contests do
		resources :questions do
			member do
				get   'contest_show'
				post 'contest_submission' => 'judge_systems#contest_judge'
			end
		end

		member do
			post 'join'
			get 'sync_ranking'
		end
	end

	resources :users, only:[:show], param: :name do 
		member do
			post 'do_unfollow'
			post 'do_follow'
			get 'follower_list'
			get 'following_list'
			post 'do_unblock'
			post 'do_block'
		end
	end

	#お問い合わせフォーム
	get 'inquiries' => 'inquiries#new'              # 入力画面
	post 'inquiries/confirm' => 'inquiries#confirm'   # 確認画面
	get 'inquiries/thanks' => 'inquiries#thanks'     # 送信完了画面
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end