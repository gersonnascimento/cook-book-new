require 'rails_helper'

feature 'User update recipe' do
  scenario 'successfully' do
    create_user
    arabian_cuisine = Cuisine.create(name: 'Arabe')
    Cuisine.create(name: 'Brasileira')

    main_type = RecipeType.create(name: 'Prato Principal')
    RecipeType.create(name: 'Sobremesa')

    Recipe.create(title: 'Bolo de cenoura', recipe_type: main_type,
                  cuisine: arabian_cuisine, difficulty: 'facil',
                  cook_time: 50,
                  ingredients: 'Farinha, açucar, cenoura',
                  method: 'Cozinhe a cenoura, corte em pedaços',
                  user_id: 1)

    visit root_path
    click_on 'Bolo de cenoura'
    click_on 'Editar'

    fill_in 'Título', with: 'Bolo de cenoura'
    select 'Brasileira', from: 'Cozinha'
    select 'Sobremesa', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Médio'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Cenoura, farinha, ovo e oleo'
    fill_in 'Como Preparar', with: 'Faça um bolo'

    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Bolo de cenoura')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Sobremesa')
    expect(page).to have_css('p', text: 'Brasileira')
    expect(page).to have_css('p', text: 'Médio')
    expect(page).to have_css('p', text: '45 minutos')
    expect(page).to have_css('p', text: 'Cenoura, farinha, ovo e oleo')
    expect(page).to have_css('p', text: 'Faça um bolo')
  end

  scenario 'and all fields must be filled' do
    create_user
    arabian_cuisine = Cuisine.create(name: 'Arabe')

    main_type = RecipeType.create(name: 'Prato Principal')

    Recipe.create(title: 'Bolo de cenoura', recipe_type: main_type,
                  cuisine: arabian_cuisine, difficulty: 'Médio',
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  method: 'Cozinhe a cenoura, corte em pedaços pequenos,
                  misture com o restante dos ingredientes',
                  user_id: 1)

    visit root_path
    click_on 'Bolo de cenoura'
    click_on 'Editar'

    fill_in 'Título', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''

    click_on 'Enviar'

    expect(page).to have_content('Você deve informar todos os dados da receita')
  end
end
def create_user
  visit new_user_registration_path
  fill_in 'Email', with: 'teste@teste.com.br'
  fill_in 'Senha', with: '123456'
  fill_in 'Confirmação da senha', with: '123456'
  click_on 'Finalizar Cadastro'
end
