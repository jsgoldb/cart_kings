Rails.application.routes.draw do

  
  resources :cart_parts, only: [:create, :destroy, :edit, :update]
  
  resources :categories do 
    resources :parts
  end

  resources :parts, only: [:show, :new, :create]

  resources :admin, only: [:index]
  
  resources :carts

  resources :orders, only: [:index, :show]
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :registrations => 'registrations' }
  
  root 'application#index'

  resources 'contacts', only: [:new, :create]
  
  get '/contacts', to: 'contacts#new'

  get '/mycart', to: 'carts#show_my_cart', as: 'my_cart'

  post '/checkout', to: 'carts#my_cart_checkout', as: 'checkout'

  post 'addtomycart/:id', to: 'cart_parts#add_to_my_cart', as: 'add_to_my_cart'
  
  get 'carts/:id/addpart', to: "cart_parts#new", as: 'add_part'
  
  get '/', to: 'application#index'

  resources :users, only: [:index, :show, :edit, :update]

  get '/addinfo', to: 'users#edit', as: 'add_info'

  match '/finish-checkout', to: "carts#my_cart_checkout", via: :post

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
