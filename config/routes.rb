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

      resources :events, only:[:show,:create]

      resources :notes, only:[:show, :create]
      delete '/notes', to:'notes#delete_all'
  
      resources :references, only:[:show, :create, :update]
      delete '/references', to:'references#delete_all'

      resources :tags, only:[:show, :index, :create]
      delete '/tags', to:'tags#delete_all'

      resources :taggings, only:[:create]
      delete '/taggings', to:'taggings#delete_all'
    end
  end
end
