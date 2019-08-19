require 'rails_helper'

feature 'admin register recipe type' do 
  scenario 'successfully' do
	  recipe_type = RecipeType.create(name:'Entrada')
	  
	  visit root_path
	  click_on 'Enviar tipo de receita'

	  fill_in 'Nome', with: 'Entrada'
	  click_on 'Enviar'

	  expect(page).to have_css('h1', text:'Tipo de receita cadastrada')
	  expect(page).to have_css('h3', text:'Entrada')
	  click_on 'Voltar'

  end
end	
