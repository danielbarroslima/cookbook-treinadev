require 'rails_helper'

describe 'Admin alterar status of recipe' do 
	it 'successfully for accept' do
		cuisine = Cuisine.create!(name:'Brasileira')
    recipe_type = RecipeType.create(name: 'Entrada')
    user = User.create!(email: 'teste@teste.com',password: 'teste123',role: :user)
    recipe = Recipe.create!(title: 'Bolodecenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user, status: :pending)

    post "/api/v1/recipes/#{recipe.id}/accept"

    expect(response.body).to include('Receita aprovada')
    expect(response.status).to eq 202
	end

	it 'fail for accept' do
		cuisine = Cuisine.create!(name:'Brasileira')
    recipe_type = RecipeType.create(name: 'Entrada')
    user = User.create!(email: 'teste@teste.com',password: 'teste123',role: :user)
    recipe = Recipe.create!(title: 'Bolodecenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user, status: :pending)

    post "/api/v1/recipes/000/accept"

    expect(response.body).to include('Receita não encontrada')
    expect(response.status).to eq 404
	end

	it 'successfully for reject' do
		cuisine = Cuisine.create!(name:'Brasileira')
    recipe_type = RecipeType.create(name: 'Entrada')
    user = User.create!(email: 'teste@teste.com',password: 'teste123',role: :user)
    recipe = Recipe.create!(title: 'Bolodecenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user, status: :pending)

    patch "/api/v1/recipes/#{recipe.id}/reject", params: {recipe:{status: :rejected}}

	  expect(response.body).to include('Receita rejeitada')
    expect(response.status).to eq 202
	end		
end
