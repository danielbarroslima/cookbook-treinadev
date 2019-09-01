require 'rails_helper'

feature 'user register recipe for validation' do
  scenario 'successfully' do 
  	recipe_type = RecipeType.create(name: 'Entrada')
    user = User.create!(email: 'teste@teste.com',password: 'teste123')

    visit root_path
    click_on 'Entrar'

    within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: 'teste123'
      click_on 'Logar'
    end  
    click_on 'Receitas'
    click_on 'Enviar uma receita'

    fill_in 'Título', with: 'Tabule marroquino'
    select 'Entrada', from: 'Tipo da Receita'
    fill_in 'Cozinha', with: 'Arabe'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limão a gosto.'
    click_on 'Enviar'

    expect(page).to have_content("Receita está no status: pending")
  end

  scenario 'revenue awaiting admin approval' do 
 	recipe_type = RecipeType.create(name: 'Sobremesa')
    RecipeType.create(name: 'Entrada')
    user = User.create(email: 'teste@teste.com', password: 'teste123')
    recipe = Recipe.create!(title: 'Bolodecenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: 'Brasileira',
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user, status: :pending)
    visit root_path

    expect(page).not_to have_content('Bolodecenoura')
  
  end	

end