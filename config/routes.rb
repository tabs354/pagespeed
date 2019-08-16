Rails.application.routes.draw do
  devise_for :users
  root "homepage#index"
  namespace :admin do
    resources :users
  end
end
