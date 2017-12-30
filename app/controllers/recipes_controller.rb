class RecipesController < ApplicationController
  def show
    @arecipe = Recipe.find(params[:id])
  end

  def new
    @new_recipe = Recipe.new
  end

  def create
    recipe = Recipe.new(title: params[:recipe][:title], recipe_type: params[:recipe][:recipe_type], cuisine_id: params[:recipe][:cuisine_id], difficulty: params[:recipe][:difficulty], cook_time: params[:recipe][:cook_time], ingredients: params[:recipe][:ingredients], method: params[:recipe][:method])
    if recipe.save
      redirect_to recipe_path(recipe.id)
    else 
      render 'error_recipe'
    end
  end
end
