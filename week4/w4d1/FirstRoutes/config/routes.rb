Rails.application.routes.draw do
  resources :users, except: [:new, :edit] do
    resources :contacts, only: :index
  end
  resources :contacts, except: [:new, :edit, :index]
  resources :contact_shares, only: [:create, :destroy]
end
