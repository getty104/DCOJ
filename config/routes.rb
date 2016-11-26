Rails.application.routes.draw do
	
 
  resources :judge_systems
	resources :codes
	resources :questions
	resources :users
	root 'static_pages#home'
	get 'static_pages/home'
		
			get 'AC' => 'judge_systems#AC'
			get 'WA' => 'judge_systems#WA'
		


	get    'login'   => 'sessions#new'
	post   'login'   => 'sessions#create'
	delete 'logout'  => 'sessions#destroy'
	get    'home'    => 'static_pages#home'
	
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
