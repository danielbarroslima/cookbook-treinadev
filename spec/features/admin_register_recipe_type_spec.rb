require 'rails_helper'

feature 'admin register recipe type' do 
  scenario 'successfully' do
    user = User.create!(email: 'teste@teste.com',password: 'teste123',role: :admin)
	  
	  visit root_path

    click_on 'Entrar'
    within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: 'teste123'
      click_on 'Logar'
    end

    click_on 'Enviar tipo de receita'

	  fill_in 'Nome', with: 'Prato Principal'
	  click_on 'Enviar'

	  expect(page).to have_css('h1', text:'Tipo de receita cadastrada')
	  expect(page).to have_css('h3', text:'Prato Principal')
	  click_on 'Voltar'

  end

  scenario 'correctly enter recipe types' do
    user = User.create!(email: 'teste@teste.com',password: 'teste123',role: :admin)
    visit root_path

    click_on 'Entrar'
    within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: 'teste123'
      click_on 'Logar'
    end


    click_on 'Enviar tipo de receita'

    fill_in 'Nome',with:''
    click_on 'Enviar'

    expect(page).to have_content("can't be blank")
  
  end

  scenario 'not permit duplicates' do
    user = User.create!(email: 'teste@teste.com',password: 'teste123',role: :admin)
  	recipe_type = RecipeType.create(name:'Entrada')
    visit root_path

    click_on 'Entrar'
    within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: 'teste123'
      click_on 'Logar'
    end

    click_on 'Enviar tipo de receita'

    fill_in 'Nome',with:'Entrada'
    click_on 'Enviar'

    expect(page).to have_content("has already been taken")
  end

  scenario 'only admin register recipe types' do

    visit new_recipe_type_path

    expect(current_path).to eq(new_user_session_path)
    expect(page).not_to have_content('Enviar tipo de receita')
  end

  scenario 'only admin view recipe types' do
    recipe_type = RecipeType.create(name:'Entrada')

    visit recipe_type_path(recipe_type)

    expect(current_path).to eq(new_user_session_path)
    expect(page).not_to have_content('Enviar tipo de receita')
  end  

  scenario 'other user access route recipe type ' do 

    user = User.create!(email: 'teste@teste.com',password: 'teste123')

    visit root_path

    click_on 'Entrar'
    within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: 'teste123'
      click_on 'Logar'
    end

    visit new_recipe_type_path

    expect(current_path).to eq(root_path)

  end

end	
