Rails.application.routes.draw do
  get 'search', to: 'search#index'
  devise_for :users
  resources :catagories
  resources :posts
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  # 
  resources :posts do
    resources :comments do
      post 'reply', on: :member
    end
  end

  resources :catagories do
    resources :posts
  end

  resources :users do
    resources :posts
  end

  get 'landingpage', to: 'posts#landingpage', as: 'landingpage'

  root to: "posts#index"

  resources :posts do
    member do
      get :expand_overview
    end
  end
  

end
