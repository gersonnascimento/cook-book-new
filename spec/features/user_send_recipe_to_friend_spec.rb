require 'rails_helper'

feature 'User send recipe to friend' do
  scenario 'successfuly' do
    user = create(:user)
    recipe = create(:recipe, title: 'Bolo de banana', user: user)

    visit root_path
    click_on recipe.title
    fill_in 'E-mail', with: 'teste@teste.com.br'
    fill_in 'Mensagem', with: 'conteudo'

    expect(RecipesMailer).to receive(:share).with('teste@teste.com.br',
                                                  'conteudo',
                                                  recipe.id).and_call_original

    click_on 'Compartilhar'

    expect(page).to have_content 'Enviada com sucesso'
    expect(current_path).to eq recipe_path(recipe)
  end
  scenario 'successfully too' do
    user = create(:user)
    recipe = create(:recipe, title: 'Bolo de banana', user: user)

    visit recipe_path(recipe)
    fill_in 'E-mail', with: 'teste@teste.com'
    fill_in 'Mensagem', with: 'conteudo'

    click_on 'Compartilhar'
    expect(page).to have_content 'Enviada com sucesso'
    expect(current_path).to eq recipe_path(recipe)
    mail = ActionMailer::Base.deliveries.last
    expect(mail.to).to include 'teste@teste.com'
    expect(mail.subject).to eq 'Compartilharam uma receita com você'
    expect(mail.body).to include 'conteudo'
    expect(mail.body).to include recipe_url(recipe, host: 'localhost:3000')
  end
end
