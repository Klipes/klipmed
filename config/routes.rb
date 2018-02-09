Rails.application.routes.draw do
  get "site/users/configuration/(:id)" => "site/users#configuration"

  namespace :site do
    resources :customers, except: [:show]
    resources :suppliers, except: [:show]
    resources :professionals, except: [:show]
    resources :receivable_categories, except: [:show]
    resources :payable_categories, except: [:show]
    resources :receivables, except: [:show]
    resources :payables, except: [:show]
    resources :schedules, except: [:show]
    resources :covenants, except: [:show]
    resources :professional_reservations, except: [:show]
    resources :users, except: [:show]
  end

  namespace :backoffice do
    resources :companies, except: [:show]
    resources :users, except: [:show]
    get 'home/index'
  end

  namespace :admin do
    get 'home/index'
  end
  
  get 'admin', to: 'backoffice/home#index'
  get 'admin/companies', to: 'backoffice/companies#index'
  
  devise_for :admins
  devise_for :users

  namespace :site do
    get 'home/index'
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'site/home#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase
end
