Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  root to: 'items#index'
  resources :items do
    collection do
      get 'sort'
    end
    resources :maintenance_histories, only: [:new, :create, :index]
  end
  get 'maintenance_histories', to: 'maintenance_histories#index', as: 'all_maintenance_histories'
end
