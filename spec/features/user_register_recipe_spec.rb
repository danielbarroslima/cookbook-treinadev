require 'rails_helper'

feature 'User register recipe' do
  scenario 'must be signed in' do 

    visit new_recipe_path
    expect(current_path).to eq(new_user_session_path)
  end	

  scenario 'successfully' do
    #cria os dados necessários, nesse caso não vamos criar dados no banco
    RecipeType.create(name: 'Sobremesa')
    RecipeType.create(name: 'Entrada')
    user = User.create!(email:'teste@teste.com',password:'teste123')

    # simula a ação do usuário
    visit root_path
    click_on 'Entrar'

    within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: 'teste123'
      click_on 'Logar'
    end   
    click_on 'Receitas'
    click_on 'Enviar uma receita'

    fill_in 'Título', with: 'Tabule Marrroquino'
    select 'Entrada', from: 'Tipo da Receita'
    fill_in 'Cozinha', with: 'Arabe'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limão a gosto.'
    click_on 'Enviar'


    # expectativas
    expect(page).to have_content('Tabule')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Entrada')
    expect(page).to have_css('p', text: 'Arabe')
    expect(page).to have_css('p', text: 'Fácil')
    expect(page).to have_css('p', text: "45 minutos")
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha')
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text:  'Misturar tudo e servir. Adicione limão a gosto.')
    expect(page).to have_content("Receita enviada por #{user.email}")
  end

  scenario 'and must fill in all fields' do
    user = User.create!(email:'teste@teste.com',password:'teste123')


    # simula a ação do usuário
    visit root_path
    click_on 'Entrar'

    within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: 'teste123'
      click_on 'Logar'
    end
    click_on 'Receitas'
    click_on 'Enviar uma receita'

    fill_in 'Título', with: ''
    fill_in 'Cozinha', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Title only allows letters and must contain spaces')
  end
end
