require 'rails_helper'

feature 'User update recipe' do
  scenario 'successfully' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe_type = RecipeType.create(name: 'Entrada')
    user = User.create!(email: 'teste@teste.com',password: 'teste123')
    recipe = Recipe.create!(title: 'Bolodecenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: 'Brasileira',
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user)
   

    # simula a ação do usuário
    visit root_path

    click_on 'Entrar'

    within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: 'teste123'
      click_on 'Logar'
    end

    click_on 'Bolodecenoura'
    click_on 'Editar'

    fill_in 'Título', with: 'Bolo de cenoura'
    select 'Entrada', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Médio'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Cenoura, farinha, ovo, oleo de soja e chocolate'
    fill_in 'Como Preparar', with: 'Faça um bolo e uma cobertura de chocolate'

    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Bolo de cenoura')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Médio')
    expect(page).to have_css('p', text: '45 minutos')
    expect(page).to have_css('p', text:  'Cenoura, farinha, ovo, oleo de soja e chocolate')
    expect(page).to have_css('p', text: 'Faça um bolo e uma cobertura de chocolate')
  end

  scenario 'and must fill in all fields' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    user = User.create!(email: 'teste@teste.com',password: 'teste123')
    Recipe.create(title: 'Bolodecenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: 'Brasileira',
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user)

    # simula a ação do usuário
    visit root_path
    
    click_on 'Entrar'

    within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: 'teste123'
      click_on 'Logar'
    end

    click_on 'Bolodecenoura'
    click_on 'Editar'

    fill_in 'Título', with: ''
    fill_in 'Cozinha', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível salvar a receita')
  end

  scenario 'user edits his recipe' do 
     recipe_type = RecipeType.create(name: 'Sobremesa')
     other_recipe_type = RecipeType.create(name: 'Entrada')
     user = User.create!(email: 'teste@teste.com',password: 'teste123')
     other_user = User.create!(email: 'otherteste@teste.com',password: 'teste123')
     recipe = Recipe.create!(title: 'Bolo de cenoura', difficulty: 'Médio',
                             recipe_type: recipe_type, cuisine: 'Brasileira',
                             cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                             cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                             user: user)
     other_recipe = Recipe.create!(title: 'Bolodecenoura', difficulty: 'Médio',
                                  recipe_type: other_recipe_type, cuisine: 'Brasileira',
                                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                                  user: other_user)   
    visit root_path
    
    click_on 'Entrar'

    within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: 'teste123'
      click_on 'Logar'
    end

    click_on other_recipe.title

    expect(page).to have_content('Bolodecenoura')
    expect(page).not_to have_link('Editar')
  end  

  scenario 'access url recipe' do 
     recipe_type = RecipeType.create(name: 'Sobremesa')
     other_recipe_type = RecipeType.create(name: 'Entrada')
     user = User.create!(email: 'teste@teste.com',password: 'teste123')
     other_user = User.create!(email: 'otherteste@teste.com',password: 'teste123')
     recipe = Recipe.create!(title: 'Bolodecenoura', difficulty: 'Médio',
                             recipe_type: recipe_type, cuisine: 'Brasileira',
                             cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                             cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                             user: user)
     other_recipe = Recipe.create!(title: 'Bolodecenoura', difficulty: 'Médio',
                                  recipe_type: other_recipe_type, cuisine: 'Brasileira',
                                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                                  user: other_user)   
    visit root_path
    
    click_on 'Entrar'

    within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: 'teste123'
      click_on 'Logar'
    end

    visit edit_recipe_path(other_recipe)

    expect(current_path).to eq(root_path)
  end  

    scenario 'access not authenticated' do 
     recipe_type = RecipeType.create(name: 'Sobremesa')
     user = User.create!(email: 'teste@teste.com',password: 'teste123')
     recipe = Recipe.create!(title: 'Bolodecenoura', difficulty: 'Médio',
                             recipe_type: recipe_type, cuisine: 'Brasileira',
                             cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                             cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                             user: user)
    
    visit recipe_path(recipe)

    expect(page).not_to have_link('Editar')
  end
end
