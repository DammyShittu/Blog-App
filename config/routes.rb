Rails.application.routes.draw do

  get 'posts/', to: 'posts#index'
  get 'posts/:id', to: 'posts#show'
  resources :users, only: [:index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
