require 'rails_helper'

feature 'user see your recipes' do 
	scenario 'successfully' do
    cuisine = Cuisine.create!(name:'Brasileira')
  	recipe_type = RecipeType.create!(name:'Entrada')
    user = User.create!(email: 'teste@teste.com', password: 'teste123')
    other_user = User.create!(email: 'other@teste.com', password: 'teste123')
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
		                       		 	  user: other_user)

  	visit root_path

  	click_on 'Entrar'

  	within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: 'teste123'
      click_on 'Logar'
    end 

    visit my_recipes_path

    expect(current_path).to eq(my_recipes_path)
    expect(page).to have_content(recipe.title)
    expect(page).not_to have_css('h1',text: other_recipe.title)
    expect(page).to  have_content("Receita enviada por #{user.email}")	
	end	

end