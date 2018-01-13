class HomeController < ApplicationController
  def index
  	@recipes = Recipe.all
	if user_signed_in?
	  @favorites = Favorite.where(user_id: current_user.id)
	  @frecipes = []	
	  if @favorites
	  @favorites.each do |fav|
            @frecipes << Recipe.find(fav.recipe_id)
	  end	
	  end
	end
  end
end
