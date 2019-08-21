Rails.application.routes.draw do
  devise_for :users

  root "homepage#index"

  namespace :admin do
    resources :users
  end

  resources :domain_name_services, except: :destroy

  get '/search', to: 'searches#new'
  post '/search', to: 'searches#show'
end
