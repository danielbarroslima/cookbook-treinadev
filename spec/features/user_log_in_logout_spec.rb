require 'rails_helper'  

feature 'user login' do 
  scenario 'successfully' do
    user = User.create!(email: 'teste@teste.com', password: 'teste123')
    
    visit root_path
    click_on 'Entrar'

    within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: 'teste123'
      click_on 'Logar'
    end  
    
    expect(page).to have_content("Olá #{user.email}")
    expect(page).not_to have_link('Entrar')
    expect(page).to have_link('Sair')
  end
 scenario 'successfully' do
    user = User.create!(email: 'teste@teste.com', password: 'teste123')
    
    visit root_path
    click_on 'Entrar'

    within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: 'teste123'
      click_on 'Logar'
    end  
    click_on 'Sair'
    expect(page).not_to have_content("Olá #{user.email}")
    expect(page).to have_link('Entrar')
    expect(page).not_to have_link('Sair')
  end  



end