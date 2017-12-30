class RecipeTypesController < ApplicationController
  def show
    @type = RecipeType.find(params[:id])
    @recipes = Recipe.where("recipe_type_id = #{@type.id}")
  end
  def new
    @new_type = RecipeType.new
  end
  def create
    type = RecipeType.new(name: params[:recipe_type][:name])
    if type.save
      redirect_to recipe_type_path(type.id)
    else
      render 'error_type'
    end
  end
end
