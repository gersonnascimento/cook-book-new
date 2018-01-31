class HomeController < ApplicationController
  before_action :type_cuisines
  def index
    @recipes = Recipe.last(6)
    vet = Favorite.group(:recipe).count
    @morefavoriteds = vet.max_by(3) { |i| i[1]} 
  end
  
  private

  def type_cuisines
    @cuisines = Cuisine.all 
    @recipe_types = RecipeType.all
  end
end
