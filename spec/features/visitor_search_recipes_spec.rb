require 'rails_helper'

feature 'Visitor search for recipes' do
  scenario 'from home page' do
    # cria os dados necessários previamente
    
	  recipe = create(:recipe)
    another_recipe= create(:recipe)
    # simula a ação do usuário
    visit root_path
    fill_in 'Busca', with: recipe.title
    click_on 'Buscar'

    # expectativas do usuário após a ação
    expect(page).to have_css('h1', text: "Resultado da busca por: #{recipe.title}")
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
    expect(page).not_to have_css('h1', text: another_recipe.title)
  end

  scenario 'and navigate to recipe details' do
    # cria os dados necessários previamente
	  recipe = create(:recipe) 

    # simula a ação do usuário
    visit root_path
    fill_in 'Busca', with: recipe.title
    click_on 'Buscar'
    click_on recipe.title

    # expectativas do usuário após a ação
    expect(current_path).to eq(recipe_path(recipe))
  end
end

