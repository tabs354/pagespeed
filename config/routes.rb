Rails.application.routes.draw do
  devise_for :users

  root 'domain_name_services#index'

  namespace :admin, only: :index do
    resources :users
  end

  resources :domain_name_services, except: :destroy do
    get 'pagespeed_insights', to: 'pagespeed_insights#show'
  end

  get '/ip_locator_api', to: 'ip_apis#show'
  get '/api_search', to: 'ip_apis#search', as: 'api_search'
end
