Rails.application.routes.draw do
  root to: 'top#index'
  get 'search', to: 'top#search'
  post 'create', to: "top#create"
  get 'thanks', to: "top#thanks"
  get 'mail_check', to: "top#mail_check"
  get 'reset_password/:token', to: "passwords#reset_password", as: "reset_password"
  post 'forgot_update_password/:token', to: "passwords#update_password", as: "forgot_update_password"
  get 'users/add_emails/:token', to: "users#add_emails", as: "add_email"
  resource :session, only: [ :new, :create, :destroy ]
  resources :users do
    member do
      get :thumbnail, :data, :edit_password, :new_email
      put :update_password
      post :create_email
    end
  end
  resources :items do
    member do
      get :thumbnail, :data1, :data2, :data3
    end
    get :search, on: :collection
    # カート、ブックマークに入れる、消す
    put :add_to_cart, :remove_from_cart, on: :member
    put :add_to_bookmark, :remove_from_bookmark, on: :member
  end
  resource :shopping_cart, only: [ :show ] do
    put :checkout
  end
  resource :bookmark, only: [ :show ]
  resources :histories, only: [ :index, :show ]

  resource :password, only: [] do
    get :forgot, :send_mail
    post :start_resetting
  end
  resources :organizations, only: [ :new, :create ]

  namespace :manager do
    resources :organizations, only: [ :show, :edit, :update ] do
      get :thumbnail, :data
      resources :items do
        member do
          get :thumbnail, :data1, :data2, :data3
        end
      end
      resources :histories
    end
  end

  get "*anything" => "top#not_found"
end
