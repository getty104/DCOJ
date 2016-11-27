Rails.application.routes.draw do
	

	resources :codes
	resources :questions
	resources :users
	root 'static_pages#home'
	get 'AC' => 'judge_systems#AC'
	get 'WA' => 'judge_systems#WA'
	get 'submission' => 'judge_systems#new'
	post 'submission' => 'judge_systems#create'
	get    'login'   => 'sessions#new'
	post   'login'   => 'sessions#create'
	delete 'logout'  => 'sessions#destroy'
	get    'home'    => 'static_pages#home'
	get    'main_menu' => 'static_pages#main_menu'
	
	resources :questions do
		member do 
			get   'download' 
		end
	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
