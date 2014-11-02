AuthDemo::Application.routes.draw do
  root to: 'static_pages#home'
  resource :session, only: [:create, :destroy, :new]
  resource :user, only: [:create, :new, :show] do
    resource :counter, only: [:update]
  end
  get '/home' => 'static_pages#home', :as => :home
  get '/about' => 'static_pages#about', :as => :about
  get '/contact' => 'static_pages#contact', :as => :contact
end
