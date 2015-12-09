require './lib/api_constraints'

Rails.application.routes.draw do
  use_doorkeeper
  namespace :api do
    scope module: :t1, constraints: ApiConstraints.new(version:"t1", default:false) do
      resources :events, only:[:create]
      delete '/events', to:'events#delete_all'
      resources :remarkables, only:[:create]
      resources :remarks, only:[:create]
      resources :universes, only:[:create]
      delete '/universes', to:'universes#delete_all'
    end

    scope module: :v1, constraints: ApiConstraints.new(version:"v1", default:true) do
      resources :universes, only: [:show, :index, :create]

      resources :articles, only:[:show, :index, :create, :update]
      delete '/articles', to:'articles#delete_all'

      resources :article_types, only: :index

      resources :books, only:[:index, :create]
      delete '/books', to:'books#delete_all'

      resources :events, only:[:show, :index, :create, :destroy]

      resources :notes, only:[:show, :create, :update, :destroy]
      delete '/notes', to:'notes#delete_all'
  
      resources :participations, only:[:create]
      delete '/participations', to:'participations#delete_all'

      resources :references, only:[:show, :create, :update]
      delete '/references', to:'references#delete_all'

      resources :relations, only:[:show, :create]
      delete '/relations', to:'relations#delete_all'

      resources :relation_types, only: :index

      delete '/remarkables', to:'remarkables#delete_all'

      resources :remarks, only:[:show,:create,:update]
      delete '/remarks', to:'remarks#delete_all'

      resources :steps, only:[:create]
      delete '/steps', to:'steps#delete_all'

      resources :tags, only:[:show, :index, :create]
      delete '/tags', to:'tags#delete_all'

      resources :taggings, only:[:create]
      delete '/taggings', to:'taggings#delete_all'
    end
  end
end
