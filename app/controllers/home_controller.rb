class HomeController < ApplicationController
  before_action :type_cuisines
  def index
    @recipes = Recipe.last(6)
    @page_title = 'Receitas'
    @not_found_message = 'Nenhuma receita encontrada.'
    take_more_favorites
  end
end
