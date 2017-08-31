Rails.application.routes.draw do
  resources :products

  resources :categories

  get "/catalogs(/:id)", to: "catalogs#index", as: "catalogs"
end
