Rails.application.routes.draw do
  resources :codes
  resources :questions
  resources :users
  root 'static_page#home'
  get 'static_page/home'
  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
