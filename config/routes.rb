Rails.application.routes.draw do
  root 'categories#index'
  get 'admin/index'

  resources :categories
  resources :tags, except: [:index]
  resources :products, except: [:new]
  resources :carts, param: :product_id
  resources :orders, except: [:destroy, :show]
  get '/orders/confirm', to: 'orders#update'

  namespace :authentication, path: '', as: '' do
    resources :users, only: [:new, :create]
    resources :sessions, only: [:new, :create]
    delete '/sessions/logout', to: 'sessions#destroy', as: 'logout'
  end
end
