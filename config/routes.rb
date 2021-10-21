Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  #top関連
  root to: 'homes#top'
  get '/about' => 'homes#about'
  
  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
  
  resources :users, only: [:index, :show, :edit, :update] do
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    resources :dogs, only:[:index, :create, :destroy]
    member do
      get :favorites
    end
  end
  
  resources :relationships, only: [:create, :destroy]
  
  resources :notifications, only: [:index]
  
  get 'search' => "searches#search"
  
  get '/post/hashtag/:hash_name' => 'posts#hashtag',as: 'hashtag_name'
  get '/post/hashtag' => 'posts#hashtag'

end
