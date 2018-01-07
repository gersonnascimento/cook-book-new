class CuisinesController < ApplicationController
  def show
    @cuisine = Cuisine.find(params[:id])
    @recipes = Recipe.where("cuisine_id = #{params[:id]}")
  end
  def new
    @cuisine = Cuisine.new
  end
  def create
    cuisine = Cuisine.new(name: params[:cuisine][:name])
    if cuisine.save
    redirect_to cuisine_path(cuisine.id)
    else
      flash[:error] = 'Você deve informar o nome da cozinha'
      redirect_to new_cuisine_path
    end
  end
end
