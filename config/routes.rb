Rails.application.routes.draw do
  devise_for :users

  root "homepage#index"

  namespace :admin do
    resources :users
  end

  resources :domain_name_services, except: :destroy do
    get 'pagespeed_insights', to: 'pagespeed_insights#show'
  end
end
