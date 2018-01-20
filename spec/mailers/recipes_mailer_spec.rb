require 'rails_helper'

RSpec.describe RecipesMailer do 
  describe 'share' do
    it 'shold send the correct email' do
      user = create(:user)
      recipe = create(:recipe, user: user)

      mail = RecipesMailer.share('teste@teste.com', 'conteudo', recipe.id)

      expect(mail.to).to include 'teste@teste.com'
      expect(mail.subject).to eq 'Compartilharam uma receita com você'
      expect(mail.from).to include 'no-reply@cookbook.com'
      expect(mail.body).to include 'conteudo'
      expect(mail.body).to include recipe_url(recipe) 
    end
    it 'shold renders the body' do
      user = create(:user)
      recipe = create(:recipe, user:user)
      mail = RecipesMailer.share('teste@teste.com', 'conteudo', recipe.id)
      expect(mail.body.encoded).to match("Faça seu cadastro do Social Recipes!")
    end
  end
end
