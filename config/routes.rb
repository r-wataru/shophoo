Rails.application.routes.draw do
  root to: 'top#index'
  resource :session, only: [ :new, :create, :destroy ]
end
