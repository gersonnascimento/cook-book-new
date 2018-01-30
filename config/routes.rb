Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :recipe_types, only: [:new, :create, :show]
  resources :cuisines, only: [:new, :create, :show]
  resources :recipes, only: [:index, :new, :create, :edit, :update, :show, :destroy] do 
    member do
      post 'favorite'
      delete 'favorite', to: 'recipes#unfavorite'
      post 'share'
      post 'star'
      delete 'star', to: 'recipes#unstar'
    end
    collection do
      get 'mine'
      get 'allrecipes'
      get 'search'
    end
  end
end
