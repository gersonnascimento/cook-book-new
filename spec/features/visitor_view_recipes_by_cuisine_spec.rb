require 'rails_helper'

feature 'Visitor view recipes by cuisine' do
  scenario 'from home page' do
    cuisine = create(:cuisine)
    recipe = create(:recipe, cuisine: cuisine)

    visit root_path
    click_on cuisine.name

    expect(page).to have_css('h1', text: cuisine.name)
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
  end

  scenario 'and view only cuisine recipes' do
    user = create(:user)
    brazilian_cuisine = create(:cuisine, name: 'Brasileira')
    dessert_recipe_type = create(:recipe_type, name: 'Sobremesa')
    brazilian_recipe = create(:recipe, cuisine: brazilian_cuisine,
                                       recipe_type: dessert_recipe_type,
                                       user: user)

    italian_cuisine = create(:cuisine, name: 'Italiana')
    main_recipe_type = create(:recipe_type, name: 'Prato Principal')
    italian_recipe = create(:recipe, cuisine: italian_cuisine,
                                     recipe_type: main_recipe_type,
                                     user: user)

    visit root_path
    click_on italian_cuisine.name

    expect(page).not_to have_css('h1', text: brazilian_recipe.title)
    expect(page).to have_css('h1', text: italian_recipe.title)
    expect(page).to have_css('li', text: italian_recipe.recipe_type.name)
    expect(page).to have_css('li', text: italian_recipe.cuisine.name)
    expect(page).to have_css('li', text: italian_recipe.difficulty)
    expect(page).to have_css('li', text: "#{italian_recipe.cook_time} minutos")
  end

  scenario 'and cuisine has no recipe' do
    recipe = create(:recipe)
    italian_cuisine = create(:cuisine, name: 'Italian')

    visit root_path
    click_on italian_cuisine.name

    expect(page).not_to have_content(recipe.title)
    expect(page).to have_content('Nenhuma receita encontrada para este tipo de cozinha')
  end
end
