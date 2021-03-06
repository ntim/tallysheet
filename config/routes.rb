Rails.application.routes.draw do
  resources :static_flashes

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  get 'login' => 'dashboard#login'

  get '/tallysheet_entries/latest'
  get '/tallysheet_entries/new_many'
  post '/tallysheet_entries/create_many'
  resources :tallysheet_entries

  get '/beverages/prices'
  resources :beverages

  get 'consumers/update_derived'
  resources :consumers do
    get 'pay'
    post 'pay'
    get 'transfer'
    post 'transfer'
    get 'mail_debt_reminder'
    get 'history'
    get 'payments'
    get 'mail'
    post 'mail'
  end
  
  get '/dashboard/weekly'
  get '/dashboard/hourly'
  get '/dashboard/mail'
  post '/dashboard/mail'
  resources :dashboard

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'dashboard#index'

  # Websockets
  get '/websocket' => 'websocket#websocket'

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
