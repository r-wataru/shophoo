Rails.application.routes.draw do
  root to: 'top#index'
  get 'search', to: 'top#search'
  get 'reset_password/:token', to: "passwords#reset_password", as: "reset_password"
  post 'forgot_update_password/:token', to: "passwords#update_password", as: "forgot_update_password"
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
  
  resource :password, only: [] do
    get :forgot, :send_mail
    post :start_resetting
  end
  
  namespace :manager do
    resources :organizations, only: [ :show ]
  end
end
