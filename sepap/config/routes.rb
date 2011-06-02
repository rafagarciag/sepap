# -*- encoding : utf-8 -*-
Sepap::Application.routes.draw do
  get "historial/index"

  get "admin/index"

	resources :attempts
	    match 'intentos/nuevo/:numero' => 'attempts#new', :as => :nuevo_intento

	resources :problems
		match 'problemas' => 'problems#index'
		match 'problemas/:numero' => 'problems#show_busqueda', :as => :show_busqueda
		match 'problemas/:id' => 'problems#show'
		match 'problems/:numero' => 'problems#show_busqueda'
		

	resources :groups
		match "grupos" => "Groups#index"
		match 'grupos/:group_id/:miembro' => 'Groups#sacar', :as => :sacar, :via => :post
		match 'grupos/:group_id' => 'Groups#show_resumen', :as => :show_resumen, :via => :post
		match 'grupos/:id' => 'Groups#show', :as => :grupo, :via => :get
		match 'grupos/:group_id/:user_id' => 'Groups#show_consulta', :as => :show_consulta
		match 'grupos/:group_id/:user_id/:problem_id' => 'Groups#show_codigo', :as => :show_codigo, :via => :get

	match 'admin/alta' => 'Admin#alta_profesores_lista', :as => :alta_profesores_lista, :via => :get
	match 'admin/alta/:miembro' => 'Admin#alta_profesores', :as => :alta_profesores, :via => :post
	
	devise_for :users

	get "home/index"

	root :to => "home#index"


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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
