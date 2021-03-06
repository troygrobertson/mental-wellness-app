SampleApp::Application.routes.draw do
  get "activities/create"
  get "activities/index"
  get "activity/index"
  
    concern :trackable do
      resources :activities, only: [:index]
    end
	resources :institutions do
	end
    resources :users, only: [:update, :index,:edit], concerns: :trackable


	resources :admins, only: [:new,:create,:edit,:update,:show]
		

	resources :patients do
	end
	resources :doctors do
	end
	resources :pools do	
	end
	resources :appointments do
	end
	#should be nested are not, will need to fix when i understand more
	resources :exercises
	resources :questions 
	resources :answers
	resources :notes
    resources :user_verifications	
	resources :messages
	#resources :users
	resources :user_sessions, only: [:new, :create, :destroy]
	root 'user_sessions#new'
	#match '/signup', to: 'users#new', via: 'get'
	match '/signin', to: 'user_sessions#new', via: 'get'
	match '/signout', to: 'user_sessions#destroy', via: 'delete'
	match '/help', to: "static_pages#help", via: 'get'
	match '/about', to: "static_pages#about", via: 'get'
	match '/news', to: "static_pages#news", via: 'get'
	match '/contact', to: "static_pages#contact", via: 'get'
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
