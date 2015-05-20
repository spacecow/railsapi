require './lib/api_constraints'

Rails.application.routes.draw do
  use_doorkeeper
  namespace :api do
    scope module: :v1, constraints: ApiConstraints.new(version:1, default:true) do
      resources :universes, only: [:index, :create]
      delete '/universes', to:'universes#delete_all'

      resources :articles, only:[:create, :index]
    end
  end
end
