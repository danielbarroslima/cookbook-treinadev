require 'rails_helper'

RSpec.describe Recipe, type: :model do
  it { is_expected.to have_db_column(:title).of_type(:string) }
  it { is_expected.to have_db_column(:cuisine).of_type(:string) }
  it { is_expected.to have_db_column(:difficulty).of_type(:string) }
  it { is_expected.to have_db_column(:cook_time).of_type(:integer) }
  it { is_expected.to have_db_column(:ingredients).of_type(:text) }
  it { is_expected.to have_db_column(:cook_method).of_type(:text) }

  describe '#owner?' do
    it 'true' do
    cuisine = Cuisine.create!(name:'Brasileira')	
     recipe_type = RecipeType.create(name: 'Sobremesa')	
     other_recipe_type = RecipeType.create(name: 'Entrada')
     user = User.create!(email: 'teste@teste.com',password: 'teste123')
     other_user = User.create!(email: 'otherteste@teste.com',password: 'teste123')
     recipe = Recipe.create!(title: 'Bolo de cenoura', difficulty: 'Médio',
                             recipe_type: recipe_type, cuisine: cuisine,
                             cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                             cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                             user: user)
     result = recipe.owner?(user)

     expect(result).to eq true

    end

    it 'false' do
     cuisine = Cuisine.create!(name:'Brasileira') 
     recipe_type = RecipeType.create(name: 'Sobremesa')
     other_recipe_type = RecipeType.create(name: 'Entrada')
     user = User.create!(email: 'teste@teste.com',password: 'teste123')
     other_user = User.create!(email: 'otherteste@teste.com',password: 'teste123')
     recipe = Recipe.create!(title: 'Bolo de cenoura', difficulty: 'Médio',
                             recipe_type: recipe_type, cuisine: cuisine,
                             cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                             cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                             user: user)
     result = recipe.owner?(other_user)

     expect(result).to eq false

    end	
  end	
end
