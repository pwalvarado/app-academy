Rails.application.routes.draw do
  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :subs, except: :destroy
  resources :posts, except: [:index, :destroy]
  resources :comments, only: [:new, :create]
end
