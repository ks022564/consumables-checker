Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :items, only: [:new, :create, :index, :show, :destroy] do
    collection do
      get 'sort'
    end
    resources :maintenance_histories, only: [:new, :create]
  end
end
