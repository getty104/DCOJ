Rails.application.routes.draw do
	
  get 'contests/new'

  get 'contests/create'

  get 'contests/edit'

  get 'contests/update'

  get 'contests/destroy'

  get 'posts/new'

  get 'posts/edit'

  get 'posts/update'

  get 'records/new'
  get 'records/edit'
  get 'records/update'

	mathjax 'mathjax'
	resources :questions
	resources :users, param: :name
	resources :contests
	root 'static_pages#home'
	get 'accept' => 'judge_systems#accept'
	post 'accept' => 'judge_systems#evaluate'
	get 'wrong_answer' => 'judge_systems#wrong_answer'
	get 'submission' => 'judge_systems#new'
	post 'submission' => 'judge_systems#create'
	get    'login'   => 'sessions#new'
	post   'login'   => 'sessions#create'
	delete 'logout'  => 'sessions#destroy'
	get    'home'    => 'static_pages#home'
	get    'main_menu' => 'static_pages#main_menu'
	get 'search_result' => 'questions#search_result'
	get 'user_search_result' => 'users#search_result'
	resources :questions do
		member do 
			get   'download_input' 
		end
	end
	resources :users, param: :name do 
		member do
			post 'do_unfollow'
			post 'do_follow'
			get 'follower_list'
			get 'following_list'
			post 'do_unblock'
			post 'do_block'
		end
		
	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
