class RecipeTypesController < ApplicationController
  before_action :type_cuisines
  
  def show
    @type = RecipeType.find(params[:id])
    @recipes = Recipe.where(recipe_type: @type)
  end

  def new
    @new_type = RecipeType.new
  end

  def create
    @new_type = RecipeType.new(receive_params)
    if @new_type.save
      redirect_to @new_type
    else
      flash[:error] = 'Você deve informar o nome do tipo de receita'
      render :new
    end
  end

  private

  def receive_params
    params.require(:recipe_type).permit(:name)
  end

  def type_cuisines
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all
  end
end
