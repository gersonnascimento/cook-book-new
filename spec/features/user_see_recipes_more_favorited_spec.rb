require 'rails_helper'

feature 'user see more favorite recipes' do
  scenario 'successfully' do
    user = create(:user)
    user2 = create(:user, email: 'teste2@teste.com')
    user3 = create(:user, email: 'marina@locaweb.com.br')

    recipe2 = create(:recipe, user: user, title: 'bolo de banana')
    recipe = create(:recipe, user: user, title: 'bolo de maçã')
    recipe3 = create(:recipe, user: user, title: 'bolo de laranja')
    recipe4 = create(:recipe, user: user, title: 'bolo de manga')

    favorite = create(:favorite, user:user, recipe: recipe2)
    favorite = create(:favorite, user:user2 , recipe: recipe2)
    favorite = create(:favorite, user:user3 , recipe:recipe2)
    favorite = create(:favorite, user:user , recipe: recipe)
    favorite = create(:favorite, user:user2 , recipe: recipe)
    favorite = create(:favorite, user:user3 , recipe:recipe3)
    favorite = create(:favorite, user:user , recipe:recipe3)
    favotite = create(:favorite, user:user3, recipe:recipe4)
    
    visit root_path

    expect(page).to have_css('h3', text: recipe2.title)
    expect(page).to have_css('h3', text: recipe.title)
    expect(page).to have_css('h3', text: recipe3.title)
    expect(page).not_to have_css('h3', text: recipe4.title)

  end
end
