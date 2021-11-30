Rails.application.routes.draw do
  get 'users/index', to: 'users#index'
  get 'users/show', to: 'users#show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
