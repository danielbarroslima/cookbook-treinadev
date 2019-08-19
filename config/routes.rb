Rails.application.routes.draw do
  root to: 'recipes#index'
  resources :recipe_types, only: %i[index show new create]
  resources :recipes, only:     %i[index show new create edit update]
end
