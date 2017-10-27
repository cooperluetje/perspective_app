Rails.application.routes.draw do
  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  post 'signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers, :getLocation
    end
  end
  resources :microposts, only: [:create, :destroy] do
    member do
      get :getLocation
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :locations, only: [:create, :destroy]
  
  namespace :api, :path => "api", :defaults => {:format => :json} do
    root 'static_pages#home'
    get '/help', to: 'static_pages#help'
    get '/about', to: 'static_pages#about'
    get '/contact', to: 'static_pages#contact'
    get '/signup', to: 'users#new'
    post 'signup', to: 'users#create'
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    post '/verify', to: 'sessions#verify'
    delete '/logout', to: 'sessions#destroy'
    resources :users do
      member do
        get :following, :followers, :feed, :getLocation
      end
    end
    resources :microposts do
      member do
        get :getLocation
      end
    end
    resources :relationships, only: [:create, :destroy]
    resources :locations, only: [:create, :destroy]
  end
  
end
