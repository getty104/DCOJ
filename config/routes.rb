Rails.application.routes.draw do
	
  resources :test_cases
	resources :codes
	resources :questions
	resources :users
	root 'static_pages#home'
	get 'static_pages/home'
	get    'login'   => 'sessions#new'
	post   'login'   => 'sessions#create'
	delete 'logout'  => 'sessions#destroy'
	get    'home'    => 'static_pages#home'
	

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
