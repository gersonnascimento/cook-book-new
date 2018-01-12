require 'rails_helper'

feature 'User remove recipe' do
  scenario 'successfully' do
    cuisine = Cuisine.create(name: 'brasileira')
    recipe_type = RecipeType.create(name: 'sobremesa')
    recipe = Recipe.create(title: 'Bolo de banana', difficulty: 'facil', cook_time: 5, ingredients: 'banana', method: 'cozinha tudo', cuisine: cuisine, recipe_type: recipe_type)
        recipe2 = Recipe.create(title: 'Bolo de laranja', difficulty: 'facil', cook_time: 5, ingredients: 'banana', method: 'cozinha tudo', cuisine: cuisine, recipe_type: recipe_type)

    visit root_path
    click_on recipe.title
    click_on 'Excluir'
				      
    expect(page).not_to have_css('h1',text: recipe.title)
    expect(page).to have_css('h1', text: recipe2.title)
    expect(page).not_to have_content('Excluir')
    expect(page).to have_content("#{recipe.title} removida com sucesso!")
  end
  
end

