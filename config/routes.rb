Rails.application.routes.draw do
  devise_for :users

  root to: 'hello_world#index'
  get 'hello_world', to: 'hello_world#index'
  resources :hello_world
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
