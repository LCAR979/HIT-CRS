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

  post '/save', to: 'overall_controll#save'

  resources :sessions, only: [:new, :create, :destroy]
  #login_path  create new session page --> (login)
  match '/login', to: 'sessions#new'
  #logout_path delete session -->(logout)   
  match '/logout', to: 'sessions#destroy'

  
  #applicant
  get "/applicants/:id/histroy", to: 'applicants#history'
  post "/applicants/:id/reset", to: 'applicants#reset'
  get "/applicants/:id/setting", to: 'applicants#setting'
  get "/applicants/:id/profile", to: 'applicants#profile'
  put "/applicants/:id/upload", to: "applicants#uploadimage" 
  get "/applicants/:id/shut_down", to: "applicants#shut_down"
  # view detail for applicants/requests
  get "/applicants/:applicant_id/requests/:request_id/show", to: "applicants#view_detail" 
  get "/applicants/:applicant_id/requests/:request_id/cancel", to: "requests#cancel"
  # click to reserve
  get "/applicants/:applicant_id/rooms/:room_id/:day/:course", to: "requests#new"

  
  #staff
  get '/staffs/:staff_id/requests/:id', to: 'requests#show'
  get '/staffs/requestProc/:id',to: 'staffs#requestProc'
  put '/staffs/audit/:id',to: 'staffs#audit'

  post "/staffs/:id/reset", to: 'staffs#reset'
  get "/staffs/:id/setting", to: 'staffs#setting'
  get "/staffs/:id/profile", to: 'staffs#profile'
  put "/staffs/:id/upload", to: "staffs#uploadimage"
  get '/staffs/:id/shut_down',to: 'staffs#shut_down'

  get '/rooms/applicant/:applicant_id', to: 'rooms#index'
  get '/rooms/staff/:staff_id', to: 'rooms#staff_room'

  # import files
  put '/staffs/:id/import', to: 'staffs#import'
  get '/staffs/:id/uploadrooms', to: 'staffs#uploadrooms'
  post 'rooms/search', to: 'rooms#search'
  #post '//:id/search', to: 'rooms#search_for_staff'
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
