Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'
  get 'search', to: 'recipes#search'
  get 'my_recipes', to: 'recipes#my_recipes'
  resources :recipe_types, only: %i[ show new create]
  resources :recipes, only:     %i[index show new create edit update] do 
    member do
      post 'add_to_list'
      post 'accept'
      post 'reject'
    end
    get 'pending', on: :collection
  end	
  resources :list_recipes, only: %i[index show new create]
  resources :cuisines, only: %i[index show new create ]

  namespace :api,  defaults: { format: 'json' } do
    namespace :v1 do 
      resources :recipes, only: %i[show create]
      resources :recipe_types, only: %i[show create]
    end
  end


end
