require 'rails_helper'

feature 'admin visit recipe' do
  scenario 'visit recipe status page' do 
    cuisine = Cuisine.create!(name:'Brasileira')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    other_user = User.create(email: 'otherteste@teste.com', password: 'teste123',role: :admin)
    user = User.create(email: 'teste@teste.com', password: 'teste123',role: :admin)
    recipe = Recipe.create!(title: 'Bolo de cenoura', difficulty: 'Médio',
                            recipe_type: recipe_type, cuisine: cuisine,
                            cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                            cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                            user:user,status: :approved)
    other_recipe = Recipe.create!(title: 'Bolo de abacaxi', difficulty: 'Médio',
                                  recipe_type: recipe_type, cuisine: cuisine,
                                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                                  user:other_user, status: :pending)
    Recipe.create!(title: 'Bolo de banana', difficulty: 'Médio',
                                  recipe_type: recipe_type, cuisine: cuisine,
                                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                                  user:other_user, status: :pending)                              

    visit root_path
    
    click_on 'Entrar'

    within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: 'teste123'
      click_on 'Logar'
    end
    
   click_on "Pendentes"

    expect(page).to have_content('Bolo de abacaxi')
    expect(page).to have_content('Bolo de banana')
    expect(page).to have_link('Aprovar')
    expect(page).to have_link('Rejeitar')
    expect(page).not_to have_content('Bolo de cenoura')
  end 
  
  scenario "accept recipe" do
    cuisine = Cuisine.create!(name:'Brasileira')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    other_user = User.create(email: 'otherteste@teste.com', password: 'teste123',role: :admin)
    user = User.create(email: 'teste@teste.com', password: 'teste123',role: :admin)
    recipe = Recipe.create!(title: 'Bolo de cenoura', difficulty: 'Médio',
                            recipe_type: recipe_type, cuisine: cuisine,
                            cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                            cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                            user:user,status: :approved)
    other_recipe = Recipe.create!(title: 'Bolo de abacaxi', difficulty: 'Médio',
                                  recipe_type: recipe_type, cuisine: cuisine,
                                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                                  user:other_user, status: :pending)
    banana = Recipe.create!(title: 'Bolo de banana', difficulty: 'Médio',
                                  recipe_type: recipe_type, cuisine: cuisine,
                                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                                  user:other_user, status: :pending) 

    visit root_path
    click_on 'Entrar'

    within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: 'teste123'
      click_on 'Logar'
    end

    click_on "Pendentes"  
    within("div#recipe-#{other_recipe.id}") do
      click_on "Aprovar"
    end

    expect(page).to have_content("Receita aprovada")
    expect(page).not_to have_content("Bolo de abacaxi")
    expect(current_path).to eq pending_recipes_path
    expect(page).to have_content("Bolo de banana")
    
  end
  scenario 'and reject recipe' do  
    cuisine = Cuisine.create!(name:'Brasileira')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    other_user = User.create(email: 'otherteste@teste.com', password: 'teste123',role: :admin)
    user = User.create(email: 'teste@teste.com', password: 'teste123',role: :admin)
    recipe = Recipe.create!(title: 'Bolo de cenoura', difficulty: 'Médio',
                            recipe_type: recipe_type, cuisine: cuisine,
                            cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                            cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                            user:user,status: :approved)
    other_recipe = Recipe.create!(title: 'Bolo de abacaxi', difficulty: 'Médio',
                                  recipe_type: recipe_type, cuisine: cuisine,
                                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                                  user:other_user, status: :pending)
    banana = Recipe.create!(title: 'Bolo de banana', difficulty: 'Médio',
                                  recipe_type: recipe_type, cuisine: cuisine,
                                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                                  user:other_user, status: :pending) 

    visit root_path
    click_on 'Entrar'

    within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: 'teste123'
      click_on 'Logar'
    end

    click_on "Pendentes"  
    within("div#recipe-#{other_recipe.id}") do
      click_on "Rejeitar"
    end

    expect(page).to have_content("Receita rejeitada")
    expect(page).not_to have_content("Bolo de abacaxi")
    expect(current_path).to eq pending_recipes_path
    expect(page).to have_content("Bolo de banana")

  end

  scenario 'validate admin' do  
    cuisine = Cuisine.create!(name:'Brasileira')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    other_user = User.create(email: 'otherteste@teste.com', password: 'teste123',role: :admin)
    user = User.create(email: 'teste@teste.com', password: 'teste123',role: :user)
    recipe = Recipe.create!(title: 'Bolo de cenoura', difficulty: 'Médio',
                            recipe_type: recipe_type, cuisine: cuisine,
                            cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                            cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                            user:user,status: :approved)
    other_recipe = Recipe.create!(title: 'Bolo de abacaxi', difficulty: 'Médio',
                                  recipe_type: recipe_type, cuisine: cuisine,
                                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                                  user:other_user, status: :pending)
    banana = Recipe.create!(title: 'Bolo de banana', difficulty: 'Médio',
                                  recipe_type: recipe_type, cuisine: cuisine,
                                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                                  user:other_user, status: :pending) 

    visit root_path
    click_on 'Entrar'

    within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: 'teste123'
      click_on 'Logar'
    end

    visit pending_recipes_path
    
    expect(current_path).to eq root_path

  end

end  