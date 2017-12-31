Rails.application.routes.draw do
  root to: "home#index"
  get '/search', to: "recipes#search"
  resources :recipe_types
  resources :cuisines
  resources :recipes
end
