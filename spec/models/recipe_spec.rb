require 'rails_helper'

RSpec.describe Recipe, type: :model do
  context 'Recipe something rsrs' do
    it 'recipe belongs to user' do
      user = create(:user)
      user2 = create(:user, email: 'teste@teste.com')
      recipe = create(:recipe, user:user)

      expect(recipe.editable_by? user).to eq(true)
      expect(recipe.editable_by? user2).to eq(false) 
    end
  end
end
