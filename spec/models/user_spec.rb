require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Favoriting  recipes' do
   it 'user favorited recipe' do
     user = create(:user)
     recipe = create(:recipe, user: user)
     favorite = create(:favorite, user: user, recipe: recipe)

     expect(user.favorited? recipe).to eq(true)
   end
   it 'user not favorited recipe' do
     user = create(:user)
     recipe = create(:recipe, user: user)

     expect(user.favorited? recipe).to eq(false)
   end
  end
end
