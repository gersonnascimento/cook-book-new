class RecipesController < ApplicationController
  def show
    @arecipe = Recipe.find(params[:id])
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all
  end

  def new
    @recipe = Recipe.new
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all
  end

  def create
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all
    recipe = Recipe.create(title: params[:recipe][:title], recipe_type_id: params[:recipe][:recipe_type_id], cuisine_id: params[:recipe][:cuisine_id], difficulty: params[:recipe][:difficulty], cook_time: params[:recipe][:cook_time], ingredients: params[:recipe][:ingredients], method: params[:recipe][:method])
    if recipe.save
      redirect_to recipe_path(recipe.id)
    else 
      render 'error_recipe'
    end
  end
  def edit
   @cuisines = Cuisine.all
   @recipe_types = RecipeType.all
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
  def search 
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all
    @word = params[:word]
    @recipes = Recipe.where("title = '#{@word}'")
  end
end
