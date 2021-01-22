Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # CRUD for shops
  resources :shops, except: %i[destroy]

  resources :vehicles, except: %i[destroy] do
    resources :invoices, except: %i[destroy]
    resources :vehicle_fuels, except: %i[show edit update]
    resources :refuels, except: %i[show edit update]
    resources :maintenance_plans, except: %i[show]
    resources :maintenances, except: %i[show] do
      resources :operations, except: %i[show]
    end
    resources :reminders, except: %i[show]
    resources :documentations, except: %i[show destroy]
  end
end
