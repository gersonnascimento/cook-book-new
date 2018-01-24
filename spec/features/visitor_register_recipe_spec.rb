require 'rails_helper'

feature 'Visitor register recipe' do
  scenario 'successfully' do
    #cria os dados necessários
    create_user
    Cuisine.create(name: 'Arabe')
    RecipeType.create(name: 'Entrada')
    RecipeType.create(name: 'Prato Principal')
    RecipeType.create(name: 'Sobremesa')
    # simula a ação do usuário
    visit root_path
    click_on 'Enviar uma receita'

    fill_in 'Título', with: 'Tabule'
    select 'Arabe', from: 'Cozinha'
    select 'Entrada', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limão a gosto.'
    click_on 'Enviar'


    expect(page).to have_css('h1', text: 'Tabule')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Entrada')
    expect(page).to have_css('p', text: 'Arabe')
    expect(page).to have_css('p', text: 'Fácil')
    expect(page).to have_css('p', text: "45 minutos")
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha')
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text:  'Misturar tudo e servir. Adicione limão a gosto.')
  end

  scenario 'and must fill in all fields' do
    #cria os dados necessários, nesse caso não vamos criar dados no banco
    create_user
    Cuisine.create(name: 'Arabe')
    # simula a ação do usuário
    visit root_path
    click_on 'Enviar uma receita'

    fill_in 'Título', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'


    expect(page).to have_content('Não foi possível criar sua receita')
  end
  scenario 'recipe have author' do

    create_user
    Cuisine.create(name: 'Arabe')
    RecipeType.create(name: 'Entrada')
    RecipeType.create(name: 'Prato Principal')
    RecipeType.create(name: 'Sobremesa')
    # simula a ação do usuário
    visit root_path
    click_on 'Enviar uma receita'

    fill_in 'Título', with: 'Tabule'
    select 'Arabe', from: 'Cozinha'
    select 'Entrada', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limão a gosto.'
    click_on 'Enviar'

    expect(page).to have_css('h1', text:"Tabule")
    expect(page).to have_content('(teste@teste.com.br)')
    expect(page).not_to have_content('Título')
  end
  scenario 'cook_time can not be string' do
    user = create(:user)
    cuisine = create(:cuisine)
    recipe_type = create(:recipe_type)
    login_as user
    visit new_recipe_path

    fill_in 'Título', with: 'Tabule'
    select cuisine.name, from: 'Cozinha'
    select recipe_type.name, from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: 'Quarenta e cinco'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limão a gosto.'
    click_on 'Enviar'
    
    expect(page).to have_content("Não foi possível criar sua receita")
    expect(page).to have_content("Tempo de Preparo não é um número")
  end

  scenario 'recipe have picture' do
    recipe = create(:recipe)

    login_as recipe.user
    visit root_path

    expect(page).to have_css("img[src*='imagemteste.png']")
  end

end
def create_user
  visit new_user_registration_path
  fill_in 'Email', with: 'teste@teste.com.br'
  fill_in 'Senha', with: '123456'
  fill_in 'Confirmação da senha', with: '123456'
  click_on 'Finalizar Cadastro' 
end
