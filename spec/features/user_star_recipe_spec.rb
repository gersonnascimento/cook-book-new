require 'rails_helper'

feature 'User star recipe' do
  scenario 'successfully' do
    user = create(:user)
    recipe = create(:recipe, user: user)

    login_as user
    visit root_path
    click_on recipe.title
    click_on 'Star'

    expect(page).to have_content('Unstar')
    expect(page).to have_content('Receita marcada com sucesso')
  end
end
