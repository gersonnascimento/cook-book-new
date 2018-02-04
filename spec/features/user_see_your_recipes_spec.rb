require 'rails_helper'
  feature 'user see your recipes' do
    scenario 'successfully' do
      user = create(:user)
      recipe = create(:recipe, user: user)

      login_as user
      visit root_path
      click_on 'Minhas Receitas'

      expect(page).to have_css('h1', text: 'Minhas Receitas')
      expect(page).to have_css('h1', text: recipe.title)
      expect(page).to have_css('li', text: recipe.recipe_type.name)
      expect(page).to have_css('li', text: recipe.cuisine.name)
      expect(page).to have_css('li', text: recipe.difficulty)
      expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
    end

    scenario 'and have not recipes' do
      user = create(:user)

      login_as user
      visit mine_recipes_path

      expect(page).to have_content('Você ainda não cadastrou nenhuma receita.')
    end
  end
