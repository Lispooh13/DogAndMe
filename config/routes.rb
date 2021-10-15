Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  #top関連
  root to: 'homes#top'
  get '/about' => 'homes#about'
  
  #post関連
  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
  
  #user関連
  resources :users, only: [:index, :show, :edit, :update] do
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    member do
      get :favorites
    end
  end
  
  
  resources :relationships, only: [:create, :destroy]
  
  resources :dogs, only:[:index, :create, :destroy]
  
  get 'search' => "searches#search"

end
