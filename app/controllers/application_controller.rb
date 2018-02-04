class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def take_more_favorites
    vet = Favorite.group(:recipe).count
    @morefavoriteds = vet.max_by(3) { |i| i[1]}
    render 'home/index'
  end

  def type_cuisines
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all
  end

  def take_data
    type_cuisines
    take_more_favorites
  end
end
