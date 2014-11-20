Rails.application.routes.draw do
  root to: 'root#root'
  
  resources :posts, only: [:create, :index, :show, :destroy, :update]
end
