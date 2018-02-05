require 'rails_helper'

feature 'user admin your recipes' do
  scenario 'edit no success' do
    create_user
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe_type = RecipeType.create(name: 'Principal')
    recipe = Recipe.create(title: 'Bolo de banana', difficulty: 'facil',
                           cook_time: 5, ingredients: 'banana',
                           method: 'cozinha tudo', cuisine: cuisine,
                           recipe_type: recipe_type, user_id: 1)
    create_another_user
    visit recipe_path(recipe)

    expect(page).not_to have_content('Editar')
  end

  scenario 'no edit url' do
    create_user
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe_type = RecipeType.create(name: 'Principal')
    recipe = Recipe.create(title: 'Bolo de banana', difficulty: 'facil',
                           cook_time: 5, ingredients: 'banana',
                           method: 'cozinha tudo', cuisine: cuisine,
                           recipe_type: recipe_type, user_id: 1)
    create_another_user
    visit edit_recipe_path(recipe)

    expect(page).to have_content('Você não pode editar esta receita')
    expect(page).to have_css('h1', text: 'Receitas')
    expect(page).not_to have_content('Ingredientes')
  end
end
def create_user
  visit new_user_registration_path
  fill_in 'Email', with: 'teste@teste.com.br'
  fill_in 'Senha', with: '123456'
  fill_in 'Confirmação da senha', with: '123456'
  click_on 'Finalizar Cadastro'
end

def create_another_user
  click_on 'Sair'
  visit new_user_registration_path
  fill_in 'Email', with: 'teste2@teste2.com.br'
  fill_in 'Senha', with: '123456'
  fill_in 'Confirmação da senha', with: '123456'
  click_on 'Finalizar Cadastro'
end
