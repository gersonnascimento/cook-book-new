class RecipesController < ApplicationController
  def show
    @arecipe = Recipe.find(params[:id])
  end

  def new
    @new_recipe = Recipe.new
  end

  def create
    recipe = Recipe.create(title: params[:recipe][:title], recipe_type_id: params[:recipe][:recipe_type_id], cuisine_id: params[:recipe][:cuisine_id], difficulty: params[:recipe][:difficulty], cook_time: params[:recipe][:cook_time], ingredients: params[:recipe][:ingredients], method: params[:recipe][:method])
    if recipe.save
      redirect_to recipe_path(recipe.id)
    else 
      render 'error_recipe'
    end
  end
  def edit
   @recipe = Recipe.find(params[:id]) 
  end
  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(title: params[:recipe][:title], recipe_type_id: params[:recipe][:recipe_type_id], cuisine_id: params[:recipe][:cuisine_id], difficulty: params[:recipe][:difficulty], cook_time: params[:recipe][:cook_time], ingredients: params[:recipe][:ingredients], method: params[:recipe][:method])
    redirect_to recipe_path(@recipe.id)
    else
    render 'error_recipe'
    end
  end
end
