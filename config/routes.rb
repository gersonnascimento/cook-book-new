Rails.application.routes.draw do
  root to: "home#index"
  get '/search', to: "recipes#search"
  resources :recipe_types, only: [:new, :create, :show]
  resources :cuisines, only: [:new, :create, :show]
  resources :recipes, only: [:index, :new, :create, :edit, :update, :show, :destroy]
end
