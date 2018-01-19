require 'rails_helper'

feature 'User star recipe' do
  scenario 'successfully' do
    user = create(:user)
    recipe = create(:recipe, user: user)

    login_as user
    visit recipe_path(recipe)
    click_on 'Star'

    expect(page).to have_content('Unstar')
    expect(page).to have_content('Receita marcada com sucesso')
  end

  scenario 'recipe stared appear different at home' do
    user = create(:user)
    recipe = create(:recipe)

    login_as user
    visit recipe_path(recipe)
    click_on 'Star'
    visit root_path

    expect(page).to have_content('(stared)')
    expect(page).not_to have_link('Star')
  end

  scenario 'only logge users can star recipes' do
    recipe = create(:recipe)

    visit recipe_path(recipe)

    expect(page).not_to have_link 'Star'
  end
end
