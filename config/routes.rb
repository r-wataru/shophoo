Rails.application.routes.draw do
  root to: 'top#index'
  get 'search', to: 'top#search'
  resource :session, only: [ :new, :create, :destroy ]
  resources :items do
    get :search, on: :collection
  end
end
