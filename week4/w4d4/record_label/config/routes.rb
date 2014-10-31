Rails.application.routes.draw do
  root 'bands#index'
  resources :users, only: [:show, :index, :new, :create]
  resource :session, only: [:new, :create, :destroy]
  
  resources :bands do
    resources :albums, only: :new
  end

  resources :albums, except: [:new, :index] do
    resources :tracks, only: [:new]
  end
  
  resources :tracks, except: [:new, :index] do
    resources :notes, only: [:new, :create]
  end

  resources :notes, except: [:create, :new]
end
