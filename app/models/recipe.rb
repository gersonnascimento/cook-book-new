class Recipe < ApplicationRecord
  validates :title, :ingredients, :method, presence:true
  validates :difficulty, inclusion: { in: %w(fácil médio difícil facil medio dificil Fácil Médio Difícil Facil Medio Dificil)}
  belongs_to :cuisine
  belongs_to :recipe_type
  belongs_to :user
  has_many :favorites, dependent: :destroy

  def empty
    title.empty? && difficulty.empty? && cook_time.nil? && ingredients.empty? && method.empty? && cuisine.nil? && recipe_type.nil?
  end
end
