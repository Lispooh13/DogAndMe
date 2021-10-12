Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: 'homes#top'
  get '/about' => 'homes#about'
  
  resources :posts
  
  resources :users, only: [:show, :edit, :update]
  
  get 'search' => "searches#search"
  
end
