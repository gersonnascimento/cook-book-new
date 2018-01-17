class HomeController < ApplicationController
  def index
  	@recipes = Recipe.last(6)
	if user_signed_in?
  	@favorites = current_user.favorite_recipes
	end
	end
  end
