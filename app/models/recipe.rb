class Recipe < ApplicationRecord
  validates :title, :difficulty, :cook_time, :ingredients, :method, presence:true
  belongs_to :cuisine
  belongs_to :recipe_type

  def empty
    title.empty? && difficulty.empty? && cook_time.nil? && ingredients.empty? && method.empty? && cuisine.nil? && recipe_type.nil?
  end
end
