class RecipeTypesController < ApplicationController
  def show
    @type = RecipeType.find(params[:id])
    @recipes = Recipe.where("recipe_type_id = #{@type.id}")
  end
end
