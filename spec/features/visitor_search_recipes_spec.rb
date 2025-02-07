require 'rails_helper'

feature 'search recipes' do
  scenario 'successfully' do 
    cuisine = Cuisine.create!(name:'Brasileira')
  	recipe_type = RecipeType.create!(name:'Entrada')
    user = User.create!(email: 'teste@teste.com', password: 'teste123')
  	recipe = Recipe.create!(title: 'Bolo de fubá', recipe_type: recipe_type,
                            cuisine: cuisine, difficulty: 'Médio',
                            cook_time: 60,
                            ingredients: 'Farinha, açucar, cenoura',
                            cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                            user: user)
  	other_recipe = Recipe.create!(title: 'Bolo de cenoura', recipe_type: recipe_type,
		                          cuisine: cuisine, difficulty: 'Médio',
		                          cook_time: 60,
		                          ingredients: 'Farinha, açucar, cenoura',
		                          cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                              user: user)
  	visit root_path

  	fill_in 'search_recipe', with: 'Bolo de cenoura'
  	click_on 'Buscar'

  	expect(page).to have_content('Bolo de cenoura')
  	expect(page).not_to have_content(recipe.title)

  end

  scenario 'fail in search' do
    cuisine = Cuisine.create!(name:'Brasileira')
  	recipe_type = RecipeType.create!(name:'Entrada')
    user = User.create!(email: 'teste@teste.com', password: 'teste123')
  	recipe = Recipe.create!(title: 'Bolo de fubá', recipe_type: recipe_type,
                            cuisine: cuisine, difficulty: 'Médio',
                            cook_time: 60,
                            ingredients: 'Farinha, açucar, cenoura',
                            cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                            user: user)
  	other_recipe = Recipe.create!(title: 'Bolo de cenoura', recipe_type: recipe_type,
    		                          cuisine: cuisine, difficulty: 'Médio',
    		                          cook_time: 60,
    		                          ingredients: 'Farinha, açucar, cenoura',
    		                          cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                                  user: user)
  	visit root_path

  	fill_in 'search_recipe', with:'Pavê'
  	click_on 'Buscar'

  	expect(page).to have_content('Nenhuma receita encontrada com este nome')

  end	

  scenario 'search include recipe' do 
    cuisine = Cuisine.create!(name:'Brasileira')
	  recipe_type = RecipeType.create!(name:'Entrada')
    user = User.create!(email: 'teste@teste.com', password: 'teste123')

  	recipe = Recipe.create!(title: 'Bolo de fubá', recipe_type: recipe_type,
                            cuisine: cuisine, difficulty: 'Médio',
                            cook_time: 60,
                            ingredients: 'Farinha, açucar, cenoura',
                            cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                            user: user)
  	other_recipe = Recipe.create!(title: 'Bolo de cenoura', recipe_type: recipe_type,
    		                          cuisine: cuisine, difficulty: 'Médio',
    		                          cook_time: 60,
    		                          ingredients: 'Farinha, açucar, cenoura',
    		                          cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                                  user: user)
    another_recipe = Recipe.create!(title: 'torta de frango', recipe_type: recipe_type,
    		                            cuisine: cuisine, difficulty: 'Médio',
    		                            cook_time: 60,
    		                            ingredients: 'Farinha, açucar, cenoura',
    		                            cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                                    user: user)
  	visit root_path  

  	fill_in 'search_recipe', with:'Bolo'
  	click_on 'Buscar'

  	expect(page).to have_content('Bolo de fubá')
  	expect(page).to have_content('Bolo de cenoura')	
  	expect(page).not_to have_content('torta de frango')	



  	
  end	
end  	