Rails.application.routes.draw do
  devise_for :users
  root "homepage#index"
  namespace :admin do
    resources :users
  end
  resources :domain_name_services, only: :index
end
