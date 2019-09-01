require 'rails_helper'

feature 'Admin register cuisine' do 
	scenario 'successfully' do 
    user = User.create!(email: 'teste@teste.com',password: 'teste123',role: :admin)

	  visit root_path

    click_on 'Entrar'
    within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: 'teste123'
      click_on 'Logar'
    end

    click_on 'Cozinhas'
    click_on 'Cadastrar cozinha'

    fill_in 'Nome', with: 'Brasileira'
    click_on 'Enviar'

	  expect(page).to have_content('Brasileira')
    expect(page).to have_link('Voltar')
    	  
	end

	scenario 'not cuisine blank' do 
    user = User.create!(email: 'teste@teste.com',password: 'teste123',role: :admin)

	  visit root_path

    click_on 'Entrar'

    within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: 'teste123'
      click_on 'Logar'
    end

    click_on 'Cozinhas'
    click_on 'Cadastrar cozinha'

	  fill_in 'Nome', with: ''
	  click_on 'Enviar'

	  expect(page).to have_content("can't be blank Name is too short")  
	end

	scenario 'not register duplicates' do 
    user = User.create!(email: 'teste@teste.com',password: 'teste123',role: :admin)
    cuisine = Cuisine.create!(name:'Brasileira')
	  visit root_path

    click_on 'Entrar'

    within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: 'teste123'
      click_on 'Logar'
    end

    click_on 'Cozinhas'
    click_on 'Cadastrar cozinha'

	  fill_in 'Nome', with: 'Brasileira'
	  click_on 'Enviar'

	  expect(page).to have_content('has already been taken')  
	end

  scenario 'only admin register cuisine ' do 
    user = User.create!(email: 'teste@teste.com',password: 'teste123',role: :user)

    visit root_path

    click_on 'Entrar'

    within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: 'teste123'
      click_on 'Logar'
    end

    visit new_cuisine_path
    expect(current_path).to eq(root_path)
  end  

	scenario 'only admin visit cuisine id' do 
    user = User.create!(email: 'teste@teste.com',password: 'teste123',role: :user)
    cuisine = Cuisine.create!(name:'Brasileira')

	  visit root_path

    click_on 'Entrar'

    within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: 'teste123'
      click_on 'Logar'
    end

    visit cuisine_path(cuisine)

	  expect(current_path).to eq(root_path)
	end

  scenario 'only admin visit cuisine id' do 
    cuisine = Cuisine.create!(name:'Brasileira')

    visit cuisine_path(cuisine)

    expect(current_path).to eq(new_user_session_path)
  end

end
