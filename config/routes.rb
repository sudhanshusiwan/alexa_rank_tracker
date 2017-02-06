Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users
  ActiveAdmin.routes(self)

  root to: 'users#dashboard'

  resources :users, only: [] do
    get :settings, on: :collection
  end

  resources :websites, only: [] do
    post :create_or_update, on: :collection
  end
end
