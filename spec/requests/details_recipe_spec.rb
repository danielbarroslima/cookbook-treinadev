require 'rails_helper'

describe 'request details of recipe' do 
	it 'succesfully json recipe' do 
		cuisine = Cuisine.create!(name:'Brasileira')
    recipe_type = RecipeType.create(name: 'Entrada')
    user = User.create!(email: 'teste@teste.com',password: 'teste123',role: :user)
    recipe = Recipe.create!(title: 'Bolodecenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user, status: :approved)

    get api_v1_recipe_path(recipe)

    json_recipe = JSON.parse(response.body, symbolize_names: true)

    expect(json_recipe[:title]).to include('Bolodecenoura')
    expect(response.status).to eq 200
	end

	it 'fail in json recipe' do 
		cuisine = Cuisine.create!(name:'Brasileira')
    recipe_type = RecipeType.create(name: 'Entrada')
    user = User.create!(email: 'teste@teste.com',password: 'teste123',role: :user)
    recipe = Recipe.create!(title: 'Bolodecenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user, status: :approved)

    get '/api/v1/recipes/000'

    json_recipe = JSON.parse(response.body, symbolize_names: true)

    expect(json_recipe[:message]).to include('Receita não encontrada')
    expect(response.status).to eq 404
	end
end