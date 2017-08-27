Rails.application.routes.draw do
  resources :products

  resources :categories

  get "/catalogs", to: "catalogs#index"
  post "/catalogs/search", to: "catalogs#search"
end
