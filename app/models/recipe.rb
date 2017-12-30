class Recipe < ApplicationRecord
  validates :title, :difficulty, :cook_time, :ingredients, :method, presence:true
  belongs_to :cuisine
  belongs_to :recipe_type
end
