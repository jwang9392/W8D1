Rails.application.routes.draw do
  resources :users, only: [:index, :new, :create, :show]
  resources :subs, except: [:destroy]

  resource :session, only: [:new, :create, :destroy]
end
