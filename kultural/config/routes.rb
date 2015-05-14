Rails.application.routes.draw do
  root 'pages#main'

  resources :reports
  resources :places
  resources :comments
  resources :event_types
  resources :events
  resources :ratings
  resources :groups
  resources :users

  # Allow user/id/followers and user/id/following urls
  resources :users do
    member do
      get :following, :followers
    end
  end

  # Allow group/id/members urls
  resources :groups do
    member do
      get :members
    end
  end

  resources :relationships, only: [:create, :destroy]
  resources :memberships, only: [:create, :destroy]

  get '/help',    to: 'pages#help'
  get '/about',   to: 'pages#about'
  get '/contact', to: 'pages#contact'

  get '/signup', to: 'users#new'

  get '/login',     to: 'sessions#new'
  post '/login',    to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/search', to: 'search#search'
  get '/autocomplete', to: 'search#autocomplete'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
