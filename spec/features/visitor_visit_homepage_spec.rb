require 'rails_helper'

feature 'Visitor visit homepage' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'CookBook')
    expect(page).to have_css('p', text: 'Bem-vindo ao maior livro de receitas online')
  end

  scenario 'and view recipe' do
    #cria os dados necessários

    recipe = create(:recipe)
    # simula a ação do usuário
    visit root_path

    # expectativas do usuário após a ação
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
  end

  scenario 'and have not anyone recipe' do
    visit root_path

    expect(page).to have_css('h1', text: 'CookBook')
    expect(page).to have_css('p', text: 'Bem-vindo ao maior livro de receitas online')
    expect(page).to have_content('Nenhuma receita encontrada.')
  end

  scenario 'and view recipes list' do
    #cria os dados necessários
    cuisine = create(:cuisine)
    recipe_type = create(:recipe_type)
    recipe = create(:recipe, title: 'Bolo de cenoura', difficulty: 'Médio',
                          ingredients: 'Cenoura, acucar, oleo e chocolate',
                          method: 'Misturar tudo, bater e assar',
                          cook_time: 60, cuisine: cuisine, recipe_type: recipe_type)

    user = create(:user, email: 'bonecojosias@locaweb.com.br', password: '123456')
    another_cuisine = create(:cuisine, name: 'Americana')
    another_recipe_type = create(:recipe_type, name: 'Prato Principal')
    another_recipe = create(:recipe, title: 'Feijoada', difficulty: 'Difícil',
                          ingredients: 'Feijao, paio, carne seca',
                          method: 'Cozinhar o feijao e refogar com as carnes já preparadas',
                          cook_time: 90, cuisine: another_cuisine, recipe_type: another_recipe_type, user: user)

    # simula a ação do usuário
    visit root_path

    # expectativas do usuário após a ação
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")

    expect(page).to have_css('h1', text: another_recipe.title)
    expect(page).to have_css('li', text: another_recipe.recipe_type.name)
    expect(page).to have_css('li', text: another_recipe.cuisine.name)
    expect(page).to have_css('li', text: another_recipe.difficulty)
    expect(page).to have_css('li', text: "#{another_recipe.cook_time} minutos")
  end

  scenario 'view only 6 last recipes' do
    user = create(:user)
    cuisine = create(:cuisine)
    recipe_type = create(:recipe_type)
    recipe1 = create(:recipe, cuisine: cuisine, recipe_type: recipe_type, user:user)
    recipe2 = create(:recipe, cuisine: cuisine, recipe_type: recipe_type, user:user)
    recipe3 = create(:recipe, cuisine: cuisine, recipe_type: recipe_type, user:user)
    recipe4 = create(:recipe, cuisine: cuisine, recipe_type: recipe_type, user:user)
    recipe5 = create(:recipe, cuisine: cuisine, recipe_type: recipe_type, user:user)
    recipe6 = create(:recipe, cuisine: cuisine, recipe_type: recipe_type, user:user)
    recipe7 = create(:recipe, cuisine: cuisine, recipe_type: recipe_type, user:user)

    # simula a ação do usuário
    visit root_path

    # expectativas do usuário após a ação
    expect(page).not_to have_css('h1', text: recipe1.title)
    expect(page).to have_css('h1', text: recipe2.title)
    expect(page).to have_css('h1', text: recipe3.title)
    expect(page).to have_css('h1', text: recipe4.title)
    expect(page).to have_css('h1', text: recipe5.title)
    expect(page).to have_css('h1', text: recipe6.title)
    expect(page).to have_css('h1', text: recipe7.title)
    expect(page).to have_link('Ver todas as receitas')
  end
  scenario 'view all recipes' do
    user = create(:user)
    cuisine = create(:cuisine)
    recipe_type = create(:recipe_type)
    recipe1 = create(:recipe, cuisine: cuisine, recipe_type: recipe_type, user:user)
    recipe2 = create(:recipe, cuisine: cuisine, recipe_type: recipe_type, user:user)
    recipe3 = create(:recipe, cuisine: cuisine, recipe_type: recipe_type, user:user)
    recipe4 = create(:recipe, cuisine: cuisine, recipe_type: recipe_type, user:user)
    recipe5 = create(:recipe, cuisine: cuisine, recipe_type: recipe_type, user:user)
    recipe6 = create(:recipe, cuisine: cuisine, recipe_type: recipe_type, user:user)
    recipe7 = create(:recipe, cuisine: cuisine, recipe_type: recipe_type, user:user)

    # simula a ação do usuário
    visit root_path
    click_on "Ver todas as receitas"

    # expectativas do usuário após a ação
    expect(page).to have_css('h1', text: recipe1.title)
    expect(page).to have_css('h1', text: recipe2.title)
    expect(page).to have_css('h1', text: recipe3.title)
    expect(page).to have_css('h1', text: recipe4.title)
    expect(page).to have_css('h1', text: recipe5.title)
    expect(page).to have_css('h1', text: recipe6.title)
    expect(page).to have_css('h1', text: recipe7.title)
    expect(page).to have_link('Apenas mais recentes')
  end
  scenario 'and view your recipes' do
	  user = create(:user, email: 'teste@teste.com.br')
	  user2 = create(:user, email: 'teste2@teste.com.br')
	  recipe1 = create(:recipe, user: user)
	  recipe2 = create(:recipe, user: user, title: 'Mousse')
	  recipe3 = create(:recipe, user: user2, title: 'Torta')

	  login_as user
    visit mine_recipes_path

	  expect(page).to have_content(recipe1.title)
	  expect(page).to have_content(recipe2.title)
	  expect(page).not_to have_content(recipe3.title)
  end

end
