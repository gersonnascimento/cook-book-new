require 'rails_helper'

feature 'Visitor search for recipes' do
  scenario 'from home page' do
    recipe = create(:recipe)
    another_recipe = create(:recipe)
    visit root_path
    fill_in 'Busca', with: recipe.title
    click_on 'Buscar'

    expect(page).to have_css('h1',
                             text: "Resultado da busca por: #{recipe.title}")
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
    expect(page).not_to have_css('h1', text: another_recipe.title)
  end

  scenario 'and navigate to recipe details' do
    recipe = create(:recipe)

    visit root_path
    fill_in 'Busca', with: recipe.title
    click_on 'Buscar'
    click_on recipe.title

    expect(current_path).to eq(recipe_path(recipe))
  end

  scenario 'from home page' do
    create(:recipe, title: 'Pizza')

    visit root_path
    fill_in 'Busca', with: 'Lasanha'
    click_on 'Buscar'

    expect(page).to have_content('Nenhuma receita encontrada')
  end
end
