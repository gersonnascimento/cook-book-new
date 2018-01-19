require 'rails_helper'

feature 'User send recipe to friend' do
  scenario 'succesffuly' do
    user = create(:user)
    recipe = create(:recipe, title: 'Bolo de banana', user: user)

    visit root_path
    click_on recipe.title
    fill_in 'E-mail', with: 'teste@teste.com.br'
    fill_in 'Mensagem', with: 'conteudo'

    expect(RecipesMailer).to receive(:share).with('teste@teste.com.br', 'conteudo', recipe.id).and_call_original

    click_on 'Compartilhar'

    expect(page).to have_content 'Enviada com sucesso'
    expect(current_path).to eq recipe_path(recipe) 
  end
end
