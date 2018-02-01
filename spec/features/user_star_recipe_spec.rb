require 'rails_helper'

feature 'User star recipe' do
  scenario 'successfully' do
    user = create(:user)
    recipe = create(:recipe, user: user)

    login_as user
    visit recipe_path(recipe)
    click_on 'Star'

    expect(page).to have_content('Unstar')
    expect(page).to have_css("img[src*='star.png']")
    expect(page).to have_content('Receita marcada com sucesso')
  end

  scenario 'recipe stared appear different at home' do
    user = create(:user)
    recipe = create(:recipe, user: user)

    login_as user
    visit recipe_path(recipe)
    click_on 'Star'
    visit root_path

    expect(page).to have_css("img[src*='star.png']")
    expect(page).not_to have_link('Star')
  end

  scenario 'only logged users can star recipes' do
    recipe = create(:recipe)

    visit recipe_path(recipe)

    expect(page).not_to have_link 'Star'
  end
  scenario 'user unstar recipe' do
    user = create(:user)
    recipe = create(:recipe, user: user)

    login_as user
    visit recipe_path(recipe)
    click_on  'Star'
    click_on 'Unstar'

    expect(page).to have_content('Marcação removida com sucesso!')
    expect(page).to have_link('Star')
    expect(page).not_to have_link('Unstar')
  end
  scenario 'user can not star other owners recipe' do
    user = create(:user)
    user2 = create(:user, email:'teste2@teste.com.br')
    recipe = create(:recipe, user: user)

    login_as user2
    visit recipe_path(recipe)

    expect(page).not_to have_link('Star')
  end
end
