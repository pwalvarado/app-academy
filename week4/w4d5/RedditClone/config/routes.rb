Rails.application.routes.draw do
  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :subs, except: :destroy
  resources :posts, except: [:index, :destroy] do
    member do
      post 'upvote', to: 'votes#create', value: 1
      post 'downvote', to: 'votes#create', value: -1
    end
  end
  resources :comments, only: [:new, :create] do
    member do
      post 'upvote'
      post 'downvote'
    end
  end
end
