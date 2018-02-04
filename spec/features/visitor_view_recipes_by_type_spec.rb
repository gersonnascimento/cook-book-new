
require 'rails_helper'

feature 'Visitor view recipes by type' do

  scenario 'from home page' do
    # cria os dados necessários previamente

    recipe_type = create(:recipe_type)
    recipe = create(:recipe, recipe_type:recipe_type)

    # simula a ação do usuário
    visit root_path
    click_on recipe_type.name

    # expectativas do usuário após a ação
    expect(page).to have_css('h1', text: recipe_type.name)
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
  end

  scenario 'and view only recipes from same type' do
    # cria os dados necessários previamente
    dessert_recipe_type = create(:recipe_type)
    user = create(:user)
    cuisine = create(:cuisine)
    dessert_recipe = create(:recipe, user:user, cuisine: cuisine, recipe_type:dessert_recipe_type)

    main_cuisine = create(:cuisine, name:'Alemã')
    italian_cuisine = Cuisine.create(name: 'Italiana')
    main_recipe_type = create(:recipe_type, name:'Principal')
    main_recipe = create(:recipe, user:user, cuisine:main_cuisine, recipe_type: main_recipe_type, difficulty:'Difícil', cook_time:22)

    # simula a ação do usuário
    visit root_path
    click_on main_recipe_type.name

    # expectativas do usuário após a ação
    expect(page).to have_css('h1', text: main_recipe.title)
    expect(page).to have_css('li', text: main_recipe.recipe_type.name)
    expect(page).to have_css('li', text: main_recipe.cuisine.name)
    expect(page).to have_css('li', text: main_recipe.difficulty)
    expect(page).to have_css('li', text: "#{main_recipe.cook_time} minutos")
    expect(page).not_to have_css('h1', text: dessert_recipe.title)
    expect(page).not_to have_css('li', text: dessert_recipe.recipe_type.name)
    expect(page).not_to have_css('li', text: dessert_recipe.cuisine.name)
    expect(page).not_to have_css('li', text: dessert_recipe.difficulty)
    expect(page).not_to have_css('li', text: "#{dessert_recipe.cook_time} minutos")
  end

  scenario 'and type has no recipe' do
    # cria os dados necessários previamente
    recipe = create(:recipe)
    main_dish_type = create(:recipe_type, name:'Acompanhamento')
    # simula a ação do usuário
    visit root_path
    click_on main_dish_type.name

    # expectativas do usuário após a ação
    expect(page).not_to have_content(recipe.title)
    expect(page).to have_content('Nenhuma receita encontrada para este tipo de receitas')
  end
end
