Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :api do
    namespace :v1 do
      resources :products, :only => [:create]
      get 'products/new', to: 'products#new'
    end
  end

end
