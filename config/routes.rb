Rails.application.routes.draw do
  root to: "home#index"
  resources :recipe_types
  resources :cuisines
  resources :recipes
end
