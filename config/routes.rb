Roofer::Application.routes.draw do

  get "geomongo/index"

  get 'dashboard/index'

  namespace :admin do
    get '', to: 'dashboard#index', as: '/'
  end

  match 'updates' => 'updates#index'
  match 'about' => 'about#index'

  resources :roofs do
    resources :photos, module: 'roof'
    resources :statuses, module: 'roof'

    member do
      match 'buy' => 'roofs#buy'
      match 'like' => 'roofs#like'
      match 'dislike' => 'roofs#dislike'
      match 'bookmark' => 'roofs#bookmark'

      match 'instruction' => 'roofs#instruction'
    end
  end


  devise_for :users, :controllers => {
      :omniauth_callbacks => "users/omniauth_callbacks"
  }
  #, :path => '/', :path_names => {
  #    :sign_in => 'login',
  #    :sign_up => 'register'
  #}
  resources :users, :only => [:index, :destroy, :show]

  root to: "home#index"



  match 'balance' => 'balance#index'
  match 'balance/pay' => 'balance#pay'

  scope 'robokassa' do
    match 'paid'    => 'robokassa#paid',    :as => :robokassa_paid    # to handle Robokassa push request
    match 'success' => 'robokassa#success', :as => :robokassa_success # to handle Robokassa success redirect
    match 'fail'    => 'robokassa#fail',    :as => :robokassa_fail    # to handle Robokassa fail redirect
  end


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
