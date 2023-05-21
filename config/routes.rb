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
end
