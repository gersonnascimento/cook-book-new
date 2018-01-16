Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  get '/search', to: "recipes#search"
  get '/recipes/all', to: "recipes#allrecipes"
  get '/recipes/mine', to: "recipes#mine"
  resources :recipe_types, only: [:new, :create, :show]
  resources :cuisines, only: [:new, :create, :show]
  resources :recipes, only: [:index, :new, :create, :edit, :update, :show, :destroy] do 
    member do
      post 'favorite'
    end
  end
end
