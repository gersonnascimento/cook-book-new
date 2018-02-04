class CuisinesController < ApplicationController
  before_action :type_cuisines, only:[:new, :create, :show]

  def show
    @cuisine = Cuisine.find(params[:id])
    @recipes = Recipe.where("cuisine_id = #{params[:id]}")
    @page_title = @cuisine.name
    @not_found_message = 'Nenhuma receita encontrada para este tipo de cozinha'
    take_more_favorites
  end

  def new
    @cuisine = Cuisine.new
  end

  def create
    @cuisine = Cuisine.new(receive_params)
    if @cuisine.save
      redirect_to @cuisine
    else
      flash[:error] = 'Não foi possível adicionar a cozinha.'
      render :new
    end
  end

  def all
    @cuisines = Cuisine.all
  end

  private

  def receive_params
    params.require(:cuisine).permit(:name)
  end

  def type_cuisines
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
  end
end
