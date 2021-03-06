require 'rails_helper'

feature 'User remove recipe' do
  scenario 'successfully' do
    create_user
    cuisine = Cuisine.create(name: 'brasileira')
    recipe_type = RecipeType.create(name: 'sobremesa')
    recipe = Recipe.create(title: 'Bolo de banana', difficulty: 'facil',
                           cook_time: 5, ingredients: 'banana',
                           method: 'cozinha tudo', cuisine: cuisine,
                           recipe_type: recipe_type, user_id: 1)
    recipe2 = Recipe.create(title: 'Bolo de laranja', difficulty: 'facil',
                            cook_time: 5, ingredients: 'banana',
                            method: 'cozinha tudo', cuisine: cuisine,
                            recipe_type: recipe_type, user_id: 1)

    visit root_path
    click_on recipe.title
    click_on 'Excluir'

    expect(page).not_to have_css('h1', text: recipe.title)
    expect(page).to have_css('h1', text: recipe2.title)
    expect(page).not_to have_content('Excluir')
    expect(page).to have_content("#{recipe.title} removida com sucesso!")
  end
  scenario 'but only owner can do it' do
    user = create(:user)
    user2 = create(:user, email: 'other@other.com')
    recipe = create(:recipe, user: user)

    login_as user2
    visit recipe_path(recipe)

    expect(page).not_to have_link('Excluir')
    expect(page).to have_css('h1', text: recipe.title)
  end
  def create_user
    visit new_user_registration_path
    fill_in 'Email', with: 'teste@teste.com.br'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmação da senha', with: '123456'
    click_on 'Finalizar Cadastro'
  end
end
