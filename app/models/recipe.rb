class Recipe < ApplicationRecord
  has_attached_file :picture, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

  validates :title, :ingredients, :method, presence:true
  validates :difficulty, inclusion: { in: %w(fácil médio difícil facil medio dificil Fácil Médio Difícil Facil Medio Dificil)}
  belongs_to :cuisine
  belongs_to :recipe_type
  belongs_to :user
  has_many :favorites, dependent: :destroy

  def empty
    title.empty? && difficulty.empty? && cook_time.nil? && ingredients.empty? && method.empty? && cuisine.nil? && recipe_type.nil?
  end
  def editable_by? user
    self.user == user
  end

end
