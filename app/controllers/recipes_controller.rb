class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy] 
  
  def show
    @arecipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    flash[:notice] = "#{@recipe.title} removida com sucesso!"
    redirect_to root_path
  end

  def create
    @recipe = Recipe.create(receive_params)
    
    if @recipe.empty
      flash.now[:error] = 'Você deve informar todos os dados da receita'
      render :new

    elsif @recipe.title.empty?
      if @recipe.recipe_type && @recipe.cuisine && @recipe.difficulty && @recipe.cook_time && @recipe.ingredients && @recipe.method
        flash.now[:error] = 'Você deve informar o título da receita.'
        render :new
      end

    elsif @recipe.recipe_type.nil?
      if @recipe.title && @recipe.cuisine && @recipe.difficulty && @recipe.cook_time && @recipe.ingredients && @recipe.method
        flash.now[:error] = 'Você deve informar o tipo de receita.'
        render:new
      end

    elsif @recipe.cuisine.nil?
      if @recipe.title && @recipe.recipe_type && @recipe.difficulty && @recipe.cook_time && @recipe.ingredients && @recipe.method
        flash.now[:error] = 'Você deve informar a cozinha.'
        render:new
      end

    elsif @recipe.difficulty.empty?
      if @recipe.title && @recipe.recipe_type && @recipe.cuisine && @recipe.cook_time && @recipe.ingredients && @recipe.method
        flash.now[:error] = 'Você deve informar a dificuldade da receita.'
        render:new
      end

    elsif @recipe.cook_time.nil?
      if @recipe.title && @recipe.recipe_type && @recipe.cuisine && @recipe.difficulty && @recipe.ingredients && @recipe.method
        flash.now[:error] = 'Você deve informar o tempo.'
        render:new
      end

    elsif @recipe.ingredients.empty?
      if @recipe.title && @recipe.recipe_type && @recipe.cuisine && @recipe.difficulty && @recipe.cook_time && @recipe.method
        flash.now[:error] = 'Você deve informar os ingredientes.'
        render:new
      end

    elsif @recipe.method.empty?
      if @recipe.title && @recipe.recipe_type && @recipe.cuisine && @recipe.difficulty && @recipe.cook_time && @recipe.ingredients
        flash.now[:error] = 'Você deve informar como preparar a receita.'
        render:new
      end

    elsif @recipe.save
      redirect_to recipe_path(@recipe.id)
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
      flash.now[:error] = 'Você deve informar todos os dados da receita'
      render :edit
    end
  end
  def search 
    @word = params[:word]
    @recipes = Recipe.where("title = '#{@word}'")
  end

  private

  def receive_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id, :difficulty, :cook_time, :ingredients, :method)
  end
end




