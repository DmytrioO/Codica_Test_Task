Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'user/registrations'
  }

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'user#index'

  get 'profile', to: 'user#index', as: 'user_index'
  put '/profile/update', to: 'user#update', as: 'user_update'
  put '/profile/change', to: 'user#edit', as: 'user_edit'
  put '/password/change', to: 'user_password#edit', as: 'password_edit'
  put '/password/update', to: 'user_password#update', as: 'password_update'
end
