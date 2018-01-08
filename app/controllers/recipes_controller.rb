class RecipesController < ApplicationController

  
  def show
    @arecipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    recipe = Recipe.create(title: params[:recipe][:title], recipe_type_id: params[:recipe][:recipe_type_id], cuisine_id: params[:recipe][:cuisine_id], difficulty: params[:recipe][:difficulty], cook_time: params[:recipe][:cook_time], ingredients: params[:recipe][:ingredients], method: params[:recipe][:method])
    
    if recipe.empty
      flash[:error] = 'Você deve informar todos os dados da receita'
      redirect_to new_recipe_path

    elsif recipe.title.empty?
      if recipe.recipe_type && recipe.cuisine && recipe.difficulty && recipe.cook_time && recipe.ingredients && recipe.method
        flash[:error] = 'Você deve informar o título da receita.'
        redirect_to new_recipe_path
      end

    elsif recipe.recipe_type.nil?
      if recipe.title && recipe.cuisine && recipe.difficulty && recipe.cook_time && recipe.ingredients && recipe.method
        flash[:error] = 'Você deve informar o tipo de receita.'
        redirect_to new_recipe_path
      end

    elsif recipe.cuisine.nil?
      if recipe.title && recipe.recipe_type && recipe.difficulty && recipe.cook_time && recipe.ingredients && recipe.method
        flash[:error] = 'Você deve informar a cozinha.'
        redirect_to new_recipe_path
      end

    elsif recipe.difficulty.empty?
      if recipe.title && recipe.recipe_type && recipe.cuisine && recipe.cook_time && recipe.ingredients && recipe.method
        flash[:error] = 'Você deve informar a dificuldade da receita.'
        redirect_to new_recipe_path
      end

    elsif recipe.cook_time.nil?
      if recipe.title && recipe.recipe_type && recipe.cuisine && recipe.difficulty && recipe.ingredients && recipe.method
        flash[:error] = 'Você deve informar o tempo.'
        redirect_to new_recipe_path
      end

    elsif recipe.ingredients.empty?
      if recipe.title && recipe.recipe_type && recipe.cuisine && recipe.difficulty && recipe.cook_time && recipe.method
        flash[:error] = 'Você deve informar os ingredientes.'
        redirect_to new_recipe_path
      end

    elsif recipe.method.empty?
      if recipe.title && recipe.recipe_type && recipe.cuisine && recipe.difficulty && recipe.cook_time && recipe.ingredients
        flash[:error] = 'Você deve informar como preparar a receita.'
        redirect_to new_recipe_path
      end

    elsif recipe.save
      redirect_to recipe_path(recipe.id)
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
      flash[:error] = 'Você deve informar todos os dados da receita'
      redirect_to new_recipe_path
    end
  end
  def search 
    @word = params[:word]
    @recipes = Recipe.where("title = '#{@word}'")
  end
end
