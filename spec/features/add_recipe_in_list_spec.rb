require 'rails_helper'

feature 'visitor adds revenue to their list' do  
  xscenario 'successfully' do 
  	recipe_type = RecipeType.create(name: 'Sobremesa')
    user = User.create(email: 'teste@teste.com', password: 'teste123')
    other_user = User.create(email: 'other@teste.com', password: 'teste456')
    recipe = Recipe.create!(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: 'Brasileira',
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: other_user)
    list = ListRecipe.create!(name: 'Sobremesas', user: user)

    visit root_path
    click_on 'Entrar'
    within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: 'teste123'
      click_on 'Logar'
    end  
    fill_in 'Search', with: 'Bolo de cenoura'
    click_on 'Buscar'
    click_on recipe.title
    select 'Sobremesas', from: 'Lista de Receitas'
    click_on 'Adicionar'

    expect(page).to have_css('h3', text: 'Sobremesas')
    expect(page).to have_css('p', text: 'Bolo de cenoura')
    expect(page).to have_css('p', text: other_user.email)
    expect(page).to have_content('Receita adicionada com sucesso')           

  end
end
