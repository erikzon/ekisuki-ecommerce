Rails.application.routes.draw do
  get 'admin/index'
  resources :categories, except: [:show,:index]
  resources :tags, except: [:show,:index]
  # get 'products/index'

  resources :products, path: '/', except: [:new]

  namespace :authentication, path: '', as: '' do
    resources :users, only: [:new, :create]
    resources :sessions, only: [:new, :create]
    delete '/sessions/logout', to: 'sessions#destroy', as: 'logout'
  end
end
