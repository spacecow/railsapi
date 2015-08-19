require './lib/api_constraints'

Rails.application.routes.draw do
  use_doorkeeper
  namespace :api do
    scope module: :v1, constraints: ApiConstraints.new(version:1, default:true) do
      resources :universes, only: [:show, :index, :create]
      delete '/universes', to:'universes#delete_all'

      resources :articles, only:[:show, :create]
      delete '/articles', to:'articles#delete_all'

      resources :article_types, only: :index

      resources :books, only:[:index, :create]
      delete '/books', to:'books#delete_all'

      resources :notes, only:[:show, :create]
      delete '/notes', to:'notes#delete_all'
  
      resources :references, only:[:create]
      delete '/references', to:'references#delete_all'
    end
  end
end
