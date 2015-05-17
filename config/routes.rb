require './lib/api_constraints'

Rails.application.routes.draw do
  namespace :api do
    scope module: :v1, constraints: ApiConstraints.new(version:1, default:true) do
      resources :universes, only: [:index, :create]
      delete '/universes', to:'universes#delete_all'
    end
  end
end
