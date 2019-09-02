require 'rails_helper'

describe 'create recipe type' do 
  it 'successfully in create recipe type' do
  	post '/api/v1/recipe_types', params: {recipe_type:{name:'Entrada'}}

  	json_recipe_type = JSON.parse(response.body, symbolize_names: true)
  	expect(json_recipe_type[:name]).to  eq('Entrada')
  	expect(response.status).to eq 201
  end

  it 'fail create recipe type' do
  	recipe_type = RecipeType.create!(name:'Entrada')
  	post '/api/v1/recipe_types', params: {recipe_type:{ name:'Entrada' }}

  	json_recipe_type = JSON.parse(response.body, symbolize_names: true)
  	expect(json_recipe_type[:message]).to  eq('O nome não pode ser igual')
  	expect(response.status).to eq 412

  end

    it 'not have recipes recipe type' do
  	  get "/api/v1/recipe_types/000"
  	  json_recipe_type = JSON.parse(response.body, symbolize_names: true)
  	  expect(response.body).to  include('Tipo de receita não encontrada')
  	  expect(response.status).to eq 404
  end

end
