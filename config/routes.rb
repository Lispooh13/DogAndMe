Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: 'homes#top'
  get '/about' => 'homes#about'
  
  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
  
  resources :users, only: [:index, :show, :edit, :update] do
    get :favorites, on: :collection
  end
  
  resources :relationships, only: [:create, :destroy]

  get 'search' => "searches#search"

end
