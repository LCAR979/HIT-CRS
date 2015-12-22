HITCrs::Application.routes.draw do

  resources :applications
  resources :staffs
  resources :rooms
  resources :requests
  resources :applicants
  #-----------------------
  #nested routes
  resources :staffs do
    resources :requests
  end

   resources :applicants do
    resources :requests
  end
  
  resources :applicants do
    member do
      get :confirm_email
    end
  end

  resources :staffs do
    member do
      get :confirm_email
    end
  end

  #static pages
  get '/', to: 'static_pages#index' 
  get '/index', to: 'static_pages#index'  
  get '/feature', to: 'static_pages#feature'  
  get '/about', to: 'static_pages#about'
  get '/help', to: 'static_pages#help'  
  get '/signup', to: 'static_pages#signup'
  get '/login', to: 'static_pages#login'


  #about signup and login
  post '/save', to: 'overall_controll#save'
  post '/check_login', to: 'overall_controll#check_login' 
  get 'logout', to: 'overall_controll#logout'

  #applicant
  post "/applicants/:id/reset", to: 'applicants#reset'
  get "/applicants/:id/setting", to: 'applicants#setting'
  put "/applicants/:id/upload", to: "applicants#uploadimage"
  get "/applicants/:id/histroy", to: 'applicants#history'
  # view detail for applicants/requests
  get "/applicants/:applicant_id/requests/:id/show", to: "applicants#view_detail" 
  # click to reserve
  get "/applicants/:applicant_id/rooms/:room_id/:day/:course", to: "requests#new"
  # cancel a request
  get "/applicants/:applicant_id/requests/:id/cancel", to: "requests#cancel"
  get "/applicants/:id/shut_down", to: "applicants#shut_down"
  

  #staff
  post "/staffs/:id/reset", to: 'staffs#reset'
  get "/staffs/:id/setting", to: 'staffs#setting'
  put "/staffs/:id/upload", to: "staffs#uploadimage"
  get '/staffs/:staff_id/requests/:id', to: 'requests#show'
  get '/staffs/requestProc/:id',to: 'staffs#requestProc'
  put '/staffs/audit/:id',to: 'staffs#audit'
  get '/staffs/:id/shut_down',to: 'staffs#shut_down'

  get '/rooms/applicant/:applicant_id', to: 'rooms#index'
  get '/rooms/staff/:staff_id', to: 'rooms#staff_room'

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



  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
