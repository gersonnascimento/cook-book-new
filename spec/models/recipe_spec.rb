require 'rails_helper'

RSpec.describe Recipe, type: :model do
  context 'Creating recipes' do
    it 'recipe belongs to user' do
      user = create(:user)
      user2 = create(:user, email: 'teste@teste.com')
      recipe = create(:recipe, user:user)

      expect(recipe.editable_by? user).to eq(true)
      expect(recipe.editable_by? user2).to eq(false) 
    end
    it 'Cook Time can not be string' do
      recipe = build(:recipe, cook_time: 'quarenta e cinco')

      expect(recipe).not_to be_valid
    end
  end
end
