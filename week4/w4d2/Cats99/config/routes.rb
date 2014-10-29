Rails.application.routes.draw do
  resources :cats
  resources :cat_rental_requests do
    member do
      patch :approve
      patch :deny
    end
  end
end
