class RecipesController < ApplicationController
	def show
		@arecipe = Recipe.find(params[:id])
	end
end
