# -*- encoding : utf-8 -*-
Sepap::Application.routes.draw do

  get "admin/index"

	resources :attempts
		match 'intentos' => 'attempts#create', :via => :post
		match 'intentos' => 'attempts#index', :as => :attempts
		match 'intentos/nuevo' => 'attempts#new', :as => :new_attempt
	    match 'intentos/nuevo/:numero' => 'attempts#new', :as => :nuevo_intento
	    match 'intentos/ultimos' => 'attempts#show_last', :as => :show_last

	resources :problems
		match 'problemas' => 'problems#create', :via => :post
		match 'problemas' => 'problems#index', :as => :problems
		match 'problemas/:id' => 'problems#update', :via => :put
		match 'problemas/:id' => 'problems#destroy', :via => :delete
		match 'problemas/:id' => 'problems#show', :as => :problem
		match 'problemas/:id/editar' => 'problems#edit', :as => :edit_problem
		

	resources :groups
		match "grupos" => "Groups#index"
		match 'grupos/agregar/:group_id' =>'Groups#agrega_alumno',:as => :agrega_alumno , :via => :post
		match 'grupos/:group_id/:miembro' => 'Groups#sacar', :as => :sacar, :via => :post
		match 'grupos/:group_id' => 'Groups#show_resumen', :as => :show_resumen, :via => :post
		match 'grupos/:id' => 'Groups#show', :as => :grupo, :via => :get
		match 'grupos/:group_id/:user_id' => 'Groups#show_consulta', :as => :show_consulta
		match 'grupos/:group_id/:user_id/:problem_id' => 'Groups#show_codigo', :as => :show_codigo, :via => :get

	# admin_controller
	match 'admin/alta' => 'Admin#alta_profesores_lista', :as => :alta_profesores_lista, :via => :get
	match 'admin/alta/:miembro' => 'Admin#alta_profesores', :as => :alta_profesores, :via => :post
	match 'admin/eliminar' => 'Admin#eliminar_usuario_lista', :as => :eliminar_usuario_lista, :via => :get
	match 'admin/eliminar/:id' => 'Admin#eliminar_usuario', :as => :eliminar_usuario, :via => :delete
	
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
