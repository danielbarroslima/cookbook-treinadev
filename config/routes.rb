Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'
  get 'search', to: 'recipes#search'
  resources :recipe_types, only: %i[index show new create]
  resources :recipes, only:     %i[index show new create edit update]
end
