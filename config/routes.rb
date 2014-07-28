Rails.application.routes.draw do
  root to: 'top#index'
  get 'search', to: 'top#search'
  resource :session, only: [ :new, :create, :destroy ]
  resources :items do
    get :search, on: :collection
    # カート、ブックマークに入れる、消す
    put :add_to_cart, :remove_from_cart, on: :member
    put :add_to_bookmark, :remove_from_bookmark, on: :member
  end
  resource :shopping_cart, only: [ :show ] do
    put :checkout
  end
  resource :history, only: [ :show ]
end
