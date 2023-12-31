Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"


  namespace :api do
    namespace :v0 do
      # get '/markets/:id/nearest_atms', to: 'markets#nearest_atms'
      get '/markets/search', to: 'search#search'
      resources :market_vendors, only: [:create]
      delete '/market_vendors', to: 'market_vendors#destroy'
      resources :vendors, only: [:show, :create, :update, :destroy]
      resources :markets, only: [:index, :show, :search] do
        get 'nearest_atms', on: :member
        resources :vendors, only: [:index] #show all vendors for a market
      end
    end
  end

end
