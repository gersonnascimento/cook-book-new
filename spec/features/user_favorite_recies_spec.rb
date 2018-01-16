require 'rails_helper'

feature 'user favorite recipes' do
  scenario 'successfully' do
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
    click_on 'Início'

    expect(page).to have_css('h2', text: recipe.title)
    expect(page).not_to have_content('Adicionar aos favoritos')
  end
  end

  def create_user
    visit new_user_registration_path
    fill_in 'Email', with: 'teste@teste.com.br'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmação da senha', with: '123456'
    click_on 'Finalizar Cadastro' 
  end
