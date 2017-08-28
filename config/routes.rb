Rails.application.routes.draw do
  resources :products

  resources :categories

  get "/catalogs", to: "catalogs#index"
  get "/catalogs/:id", to: "catalogs#show"
end
