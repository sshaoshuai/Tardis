Tardis::Application.routes.draw do
	resources :placeclassifies

	# devise_for :users, controllers: { sessions: "users/sessions" }
	devise_for :users, path: "/", path_names: 
	{ sign_in: 'signin', sign_out: 'signout', registration: 'signup' }, 
	controllers: { sessions: "users/sessions", registrations: "users/registrations", 
	confirmations:"users/confirmations", passwords: "users/passwords",
	shared: "users/shared", unlocks: "users/unlocks", mailer: "users/mailer" 
	 }

	#get "static_pages/home"
	#get "static_pages/help"
	#get "static_pages/about"
	resources :comments
	# resources :users do
	#	 resources :comments
	# end

	# resources :sessions, only: [:new, :create, :destroy]

	resources :places do
		resources :comments
		post "rate", on: :member
	end

	resources :users #user_path
	resources :placeclassifies, only: [:new, :create, :destroy, :index, :edit, :update]

	root :to => "static_pages#home"

	get '/' => 'static_pages#home'
	get '/help' => 'static_pages#help'
	get '/home' => 'static_pages#home'
	get '/about' => 'static_pages#about'

	#get '/help' => 'static_pages#help'

	get '/manage' => 'users#manage', :as => :manage
	get 'places/:id/updateapply' => 'places#updateapply', :as => :updateapply
	post 'places/:id/updateapply' => 'places#createtemp'
	get 'auditapply/:id' => 'users#auditapply',	:as => :auditapply
	post 'auditapply/:id' => 'users#accepted'
	put 'auditapply/:id' => 'users#rejected'
	delete 'auditapply/:id' => 'users#destroy'

	get 'placeapply' => 'places#newapply', 	:as => :newapply
	post 'placeapply' => 'places#createapply'
	get '/searchshow' => 'places#searchresult', :as => :searchshow #for search page

	get '/places?classify=:id' => 'places#index', :as => :classifyshowing
	get '/places?all=1' => 'places#index', :as => :allplaces

	get 'notice' => 'static_pages#notice', :as => :notice
	# get '/signup' => 'users#new'
	# get '/signin' => 'users/sessions#new'
	# post '/signin' => 'users/sessions#create'
	# delete '/signout' => 'users/sessions#destroy'

	# devise_scope :user do
	#	 get "signup", to: "devise/registrations#new"
	#	 get "signin", to: "users/sessions#new"
	#	 post "signin", to: "users/sessions#create"
	#	 delete "signout", to: "users/sessions#destroy"
	# end

	# The priority is based upon order of creation:
	# first created -> highest priority.

	# Sample of regular route:
	#	 match 'products/:id' => 'catalog#view'
	# Keep in mind you can assign values other than :controller and :action

	# Sample of named route:
	#	 match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
	# This route can be invoked with purchase_url(:id => product.id)

	# Sample resource route (maps HTTP verbs to controller actions automatically):
	#	 resources :products

	# Sample resource route with options:
	#	 resources :products do
	#		 member do
	#			 get 'short'
	#			 post 'toggle'
	#		 end
	#
	#		 collection do
	#			 get 'sold'
	#		 end
	#	 end

	# Sample resource route with sub-resources:
	#	 resources :products do
	#		 resources :comments, :sales
	#		 resource :seller
	#	 end

	# Sample resource route with more complex sub-resources
	#	 resources :products do
	#		 resources :comments
	#		 resources :sales do
	#			 get 'recent', :on => :collection
	#		 end
	#	 end

	# Sample resource route within a namespace:
	#	 namespace :admin do
	#		 # Directs /admin/products/* to Admin::ProductsController
	#		 # (app/controllers/admin/products_controller.rb)
	#		 resources :products
	#	 end

	# You can have the root of your site routed with "root"
	# just remember to delete public/index.html.
	# root :to => 'welcome#index'

	# See how all your routes lay out with "rake routes"

	# This is a legacy wild controller route that's not recommended for RESTful applications.
	# Note: This route will make all actions in every controller accessible via GET requests.
	# match ':controller(/:action(/:id))(.:format)'
end
