Rails.application.routes.draw do
  root "users#show"
  
  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
  resources :goals, except: :index
end
