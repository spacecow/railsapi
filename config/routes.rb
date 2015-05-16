Rails.application.routes.draw do
  # root 'welcome#index'
  resources :universes, only: [:index, :create]
  delete '/universes', to:'universes#delete_all'
end
