require 'rails_helper'

feature 'user favorite recipes' do
  scenario 'successfully' do

    user = create(:user)
    arabian_cuisine = Cuisine.create(name: 'Arabe')
    dessert_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title: 'Bolodecenoura', recipe_type: dessert_type,
                           cuisine: arabian_cuisine, difficulty: 'Médio',
                           cook_time: 50,
                           ingredients: 'Farinha, açucar, cenoura',
                           method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user)

    # simula a ação do usuário
    login_as(user)
    visit root_path
    click_on 'Bolodecenoura'
    click_on 'Adicionar aos favoritos'

    expect(page).to have_content('Remover dos favoritos')
    expect(page).not_to have_content('Adicionar aos favoritos')
    expect(page).to have_content('Receita adicionada aos seus favoritos')
  end
  scenario 'user see your favorites' do
    create_user 

    arabian_cuisine = Cuisine.create(name: 'Arabe')
    dessert_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title: 'Bolodecenoura', recipe_type: dessert_type,
                           cuisine: arabian_cuisine, difficulty: 'Médio',
                           cook_time: 50,
                           ingredients: 'Farinha, açucar, cenoura',
                           method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user_id: 1)

    # simula a ação do usuário
    visit root_path
    click_on 'Bolodecenoura'
    click_on 'Adicionar aos favoritos'
    click_on 'Favoritos'

    expect(page).to have_css('h1', text: recipe.title)
    expect(page).not_to have_content('Adicionar aos favoritos')
  end
  scenario 'unfavorite recipe' do 
    user = create(:user)
    recipe = create(:recipe, user: user)
    favorite = create(:favorite, user: user, recipe: recipe)

    login_as(user)
    visit root_path
    click_on recipe.title
    click_on 'Remover dos favoritos'

    expect(page).to have_link('Adicionar aos favoritos')
    expect(page).not_to have_link('Remover do favoritos')
  end
  scenario 'unfavorite recipe and other need to be favorited' do
    user = create(:user)
    cuisine = create(:cuisine)
    recipe_type = create(:recipe_type)
    recipe = create(:recipe,title:'Bolo', user: user, cuisine: cuisine, recipe_type: recipe_type)
    recipe2 = create(:recipe, user:user, title: 'Torta', cuisine: cuisine, recipe_type: recipe_type)
    favorite = create(:favorite, user:user, recipe:recipe) 

    login_as(user)
    visit recipe_path(recipe2)

    expect(page).to have_link('Adicionar aos favoritos')
    expect(page).to have_content(recipe2.title)
    expect(page).not_to have_content(recipe.title)

  end
  scenario 'and not have to be favorited by other user' do 
    user = create(:user, email:'teste@teste.com')
    user2 = create(:user, email:'asdf@asdf.com')
    recipe = create(:recipe, user: user)
    favorite = create(:favorite, user: user, recipe: recipe)

    login_as user2
    visit root_path
    click_on recipe.title

    expect(page).to have_link('Adicionar aos favoritos')
    expect(page).to have_content(user2.email)

  end
end

def create_user
  visit new_user_registration_path
  fill_in 'Email', with: 'teste@teste.com.br'
  fill_in 'Senha', with: '123456'
  fill_in 'Confirmação da senha', with: '123456'
  click_on 'Finalizar Cadastro' 
end
