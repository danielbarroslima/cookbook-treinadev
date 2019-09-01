require 'rails_helper'

describe ListRecipe do 
  it 'have many recipes' do 
  	recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe_type = RecipeType.create(name: 'Entrada')
    user = User.create!(email: 'teste@teste.com',password: 'teste123')
    recipe = Recipe.create!(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: 'Brasileira',
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user)
    other_recipe = Recipe.create!(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: 'Brasileira',
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user)

    list = ListRecipe.create!(name: 'dieta off', user:user)
    Menu.create!(recipe: recipe, list_recipe: list)
    Menu.create!(recipe: other_recipe,list_recipe: list)
    expect(list.recipes).to include(recipe)
    expect(list.recipes).to include(other_recipe)
  end	
	
end
