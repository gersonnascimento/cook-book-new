class HomeController < ApplicationController
  before_action :type_cuisines
  def index
    @recipes = Recipe.last(6)
    vet = Favorite.group(:recipe).count
    @morefavoriteds = vet.max_by(3) { |i| i[1]} 
    if user_signed_in?
      @favorites = current_user.favorite_recipes
    end
  end
  
  private

  def type_cuisines
    @cuisines = Cuisine.all 
    @recipe_types = RecipeType.all
  end
end
