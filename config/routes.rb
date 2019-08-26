Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'
  get 'search', to: 'recipes#search'
  get 'my_recipes', to: 'recipes#my_recipes'
  resources :recipe_types, only: %i[index show new create]
  resources :recipes, only:     %i[index show new create edit update] do 
  	post 'add_to_list', on: :member
  end	
  resources :list_recipes, only: %i[index show new create]
end
