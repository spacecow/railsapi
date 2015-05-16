Rails.application.routes.draw do
  # root 'welcome#index'
  resources :universes, only: :index
end
