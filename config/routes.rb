Rails.application.routes.draw do
  root to: 'static_pages#root'

  resources :users
  resource :session
  resources :articles
  resources :authors
  resources :annotations
  resources :follows
  resources :comments
  resources :votes

  get '/home', to: 'users#home', as: 'home'
  get '/random', to: 'articles#random', as: 'random'

  get '/sign_out', to: 'sessions#destroy', as: 'sign_out'

  get '/notifications', to: 'users#notifications', as: 'notifications'
  delete '/follows', to: 'follows#destroy', as: 'destroy_follow'

  namespace :api, defaults: { format: :json } do
    resources :users, except: [:new, :edit]
    resources :annotations, except: [:new, :edit]
    resources :articles, except: [:new, :edit] do
      resources :annotations, except: [:new, :edit] do
        resources :comments, except: [:new, :edit]
      end
    end
    resources :authors, except: [:new, :edit]
    resources :follows, only: [:create]
    delete '/follows', to: "follows#destroy", as: 'unfollow'
    resources :comments, except: [:new, :edit, :index]
    post '/votes', to: "votes#create", as: 'vote'
    get '/search/', to: 'searches#search', as: 'search'
  end

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
