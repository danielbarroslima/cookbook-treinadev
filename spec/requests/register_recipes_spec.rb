require 'rails_helper'

describe 'user access cookbook to' do 
  it 'successfully create recipe ' do
  	recipe_type = RecipeType.create!(name:'Sobremesa da vóvó')
  	cuisine = Cuisine.create!(name:'brasileirasss')
  	user = User.create!(email:'teste@teste.com', password:'teste123')
  	post "/api/v1/recipes", params: {recipe:{ title: 'Bolo de cenoura', difficulty: 'Médio',
                  					 recipe_type_id: 1, cuisine_id: 1,
               					     cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                 					 cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
             					     user_id: 1}}

  	json_recipe = JSON.parse(response.body, symbolize_names: true )
  	expect(response.body).to  include('Farinha, açucar, cenoura') 
  	expect(response.status).to eq 201
  end

  it 'succeed in receiving all the recipes' do
  	recipe_type = RecipeType.create!(name:'Entrada')
  	cuisine = Cuisine.create!(name:'brasileira')
  	italian_cuisine = Cuisine.create!(name:'italiana')
  	user = User.create!(email:'teste@teste.com', password:'teste123')

  	post '/api/v1/recipes', params: {recipe:{ title: 'Bolo de cenoura', difficulty: 'Médio',
                  					 recipe_type_id:1 , cuisine_id: 1,
               					     cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                 					 cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
             					     user_id:1}}

  	post '/api/v1/recipes', params: {recipe:{ title: 'Bolo de chocolate', difficulty: 'Médio',
                  					 recipe_type_id:1, cuisine_id:1,
               					     cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                 					 cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
             					     user_id:1}}

  	json_recipe_type = JSON.parse(response.body, symbolize_names: true)

  	expect(response.body).to  include('brasileira')
  	expect(response.body).to  include('Bolo de chocolate')

  	expect(response.status).to eq 201
  end







end