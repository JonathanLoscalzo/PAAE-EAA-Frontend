Rails.application.routes.draw do

  resources :payment_forms
  resources :sales
  post 'sales/persist'
  get 'sales/result'
  get 'integration_tests/show'
  get 'alarms/show'
  get 'statistics/show'
  get 'client_sales' => 'sales#client_sales'
  resources :users
  resources :clients
  resources :suppliers
  resources :products do
    resources :batches
  end
  resources :items
  root 'home#index'
  get 'login'   => 'login#show'
  post 'login'  => 'login#signin'
  get 'create_user_and_client' => 'home#create_user_and_client'
  get 'create_payment_form' => 'home#create_payment_form'
  get 'create_client' => 'home#create_client'
  get 'create_supplier' => 'home#create_supplier'
  get 'create_product' => 'home#create_product'
  get 'create_batch' => 'home#create_batch'
  get 'create_user' => 'home#create_user'
  get 'create_all' => 'home#create_all'
  get 'consume_batch_units' => 'home#consume_batch_units'


  #get 'statistics' => 'statistics#show'

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
