require 'rails_helper'

feature 'user create list of recipes' do 
	scenario 'successfully' do
		user = User.create!(email: 'teste@teste.com',password: 'teste123')

    visit root_path
    click_on 'Entrar'
    within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: 'teste123'
      click_on 'Logar'
    end

		click_on 'Minhas listas de receitas'
    click_on 'Criar Lista de Receitas'
		fill_in 'Nome', with:'Final de Ano'
		click_on 'Criar lista'

		expect(page).to have_content('Final de Ano')
    expect(page).to have_content(user.email)
	end

	scenario 'view lists recipes' do
		user = User.create!(email: 'teste@teste.com',password: 'teste123')
		list = ListRecipe.create(name:'Final de Ano',user: user)
		other_list = ListRecipe.create(name:'Dia das mães',user: user)

    visit root_path
    click_on 'Entrar'
    within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: 'teste123'
      click_on 'Logar'
    end
    click_on 'Minhas listas de receitas'

    expect(page).to have_content('Final de Ano')
    expect(page).to have_content('Dia das mães')
    expect(page).to have_content(user.email)
	end	

	scenario 'not duplicates' do 
		user = User.create!(email: 'teste@teste.com',password: 'teste123')
		list = ListRecipe.create(name:'Final de Ano',user: user)


		visit root_path
    click_on 'Entrar'
    within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: 'teste123'
      click_on 'Logar'
    end
    click_on 'Minhas listas de receitas'
		click_on 'Criar Lista de Receitas'
		fill_in 'Nome', with:'Final de Ano'
		click_on 'Criar lista'

		expect(page).to have_content('O nome não pode ser repetido um deixado em branco')
	end	

end