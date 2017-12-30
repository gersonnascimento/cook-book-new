class Recipe < ApplicationRecord
  validates :title, :recipe_type, :difficulty, :cook_time, :ingredients, :method, presence:true
  belongs_to :cuisine
end
