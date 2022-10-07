Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :merchants, only: [:index] do
    scope module: :merchants do
      get '/dashboard', to: 'dashboard#show', as: :dashboard
      resources :items, except: [:destroy]
      resources :invoices, only: [:index, :show, :update]
      resources :bulk_discounts
      resources :invoice_items, only: [:update]
    end
  end

  get '/', to: 'welcome#index'

  namespace :admin do
    get '/', to: 'dashboard#index', as: :dashboard
    resources :items, except: [:destroy]
    resources :merchants, except: [:destroy]
    resources :invoices, only: [:index, :show, :update]
  end
end