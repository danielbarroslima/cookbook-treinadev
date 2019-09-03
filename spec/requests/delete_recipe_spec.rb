require 'rails_helper'

describe ' admin delete recipe ' do 
	it 'succesfully' do
		cuisine = Cuisine.create!(name:'Brasileira')
    recipe_type = RecipeType.create(name: 'Entrada')
    user = User.create!(email: 'teste@teste.com',password: 'teste123',role: :user)
    recipe = Recipe.create!(title: 'Bolodecenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user, status: :approved)

    delete "/api/v1/recipes/#{recipe.id}"

    expect(response.body).to include('Receita apagada com sucesso')
    expect(response.status).to eq 202 
	end

	# it 'fail in delete recipe' do
	# 	cuisine = Cuisine.create!(name:'Brasileira')
 #    recipe_type = RecipeType.create(name: 'Entrada')
 #    user = User.create!(email: 'teste@teste.com',password: 'teste123',role: :user)
 #    recipe = Recipe.create!(title: 'Bolodecenoura', difficulty: 'Médio',
 #                  recipe_type: recipe_type, cuisine: cuisine,
 #                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
 #                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
 #                  user: user, status: :approved)

 #    delete "/api/v1/recipes/#{recipe.id}"

 #    expect(response.body).to include('Receita apagada com sucesso')
 #    expect(response.status).to eq 202
	# end

end
