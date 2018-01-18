class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :favorite, :mine] 
  before_action :type_cuisines, only: [:create, :show]

  def favorite
    @arecipe = Recipe.find(params[:id])
    current_user.favorite_recipes << @arecipe
    flash[:notice] = "Receita adicionada aos seus favoritos"
    redirect_to @arecipe
  end
  def show
    @arecipe = Recipe.find(params[:id])
  end
  def allrecipes
    @recipes = Recipe.all
    render 'home/index'
  end

  def new
    @recipe = Recipe.new
  end
  def mine
    @recipes = Recipe.where(user: current_user)
    render 'home/index'
  end

  def destroy
    @arecipe = Recipe.find(params[:id])
    if @arecipe.editable_by? current_user
      @arecipe.destroy
      flash[:notice] = "#{@arecipe.title} removida com sucesso!"
      redirect_to root_path
    else
      flash.now[:notice] = "Você não pode remover esta receita"
      render :show 
    end
  end

  def create
    @recipe = Recipe.new(receive_params)
    @recipe.user = current_user

    if @recipe.save
      flash[:notice] = 'Receita criada com sucesso!'
      redirect_to @recipe
    else
      flash.now[:alert] = 'Não foi possível criar sua receita'
      render :new
    end
  end
  def edit
    @recipe = Recipe.find(params[:id]) 
    unless @recipe.editable_by? current_user
      flash[:notice] = 'Você não pode editar esta receita'
      type_cuisines
      redirect_to root_path
    end
  end
  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(title: params[:recipe][:title], recipe_type_id: params[:recipe][:recipe_type_id], cuisine_id: params[:recipe][:cuisine_id], difficulty: params[:recipe][:difficulty], cook_time: params[:recipe][:cook_time], ingredients: params[:recipe][:ingredients], method: params[:recipe][:method])
      redirect_to recipe_path(@recipe.id)
    else
      flash.now[:error] = 'Você deve informar todos os dados da receita'
      render :edit
    end
  end
  def search 
    @word = params[:word]
    @recipes = Recipe.where("title = '#{@word}'")
  end
  def unfavorite
    @recipe = Recipe.find(params[:id])
    Favorite.find_by(user: current_user, recipe: @recipe).destroy
    flash[:notice] = "Removida dos seus favoritos!"
    redirect_to @recipe
  end

  private

  def receive_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id, :difficulty, :cook_time, :ingredients, :method)
  end
  def type_cuisines
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
  end
end

