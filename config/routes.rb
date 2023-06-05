Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
    registrations: 'user/registrations'
  }

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root 'doctors#index'
  get 'doctor/:id', to: 'doctors#show', as: 'doctor'

  get 'profile', to: 'user#index', as: 'user_index'
  put '/profile/update', to: 'user#update', as: 'user_update'
  put '/profile/change', to: 'user#edit', as: 'user_edit'
  put '/password/change', to: 'user_password#edit', as: 'password_edit'
  put '/password/update', to: 'user_password#update', as: 'password_update'
  post '/appointment/new', to: 'appointments#new', as: 'appointment_new'
  post '/appointment/create', to: 'appointments#create', as: 'appointment_create'
  get '/appointments', to: 'appointments#index', as: 'appointments_index'
  get '/appointment/:id', to: 'appointments#show', as: 'appointment'
  put '/appointment/:id', to: 'appointments#update', as: 'appointment_update'
  post 'conclusion/create', to: 'conclusions#create', as: 'conclusion_create'
  post 'conclusion/new', to: 'conclusions#new', as: 'conclusion_new'
end
