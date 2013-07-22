AnalyticsPortal::Application.routes.draw do

  devise_for :users, :path_prefix => 'd'
  
  resource :account, :only => [:show, :edit, :update]
  resources :users

  resources :dashboard_reports, :only => [:edit, :update]
  resources :dashboards do
    resources :reports do
      member do
        get 'data'
      end
    end
  end
  resources :permissions, :only => [:index]
  resources :roles, :except => [:show]
  resources :reports do
    member do
      get 'data'
    end
  end
  #resources :reports, :as => :chart_reports, :controller => :reports do
  #  member do
  #    get 'data'
  #  end
  #end
  #resources :reports, :as => :table_reports, :controller => :reports do
  #  member do
  #    get 'data'
  #  end
  #end
  #resources :reports, :as => :heat_map_reports, :controller => :reports do
  #  member do
  #    get 'data'
  #  end
  #  end
  #resources :reports, :as => :kpi_reports, :controller => :reports do
  #  member do
  #    get 'data'
  #  end
  #end
  resources :data_sources
  resources :data_segments do
    member do
      get 'start'
    end
  end
  resources :job_runners do # ActiveResource
    member do
      get 'start'
    end
  end
  resources :filter_params
  resources :filter_sets, :except => [:show]

#  resources :queries
#  resources :filter_prefs
#  resources :report_queries

  resource :configuration, :only => [:show, :edit, :update]
  match 'help' => 'help#index'

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
  root :to => "home#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
