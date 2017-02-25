Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :products, :only => [:create]
  get '/products/new', to: 'products#new'
end
