Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get "/sign_up", to: "devise/registrations#new"
    get "/edit_company_profile", to: "devise/registrations#edit"
  end
  root to: "dashboard#index"

  get '/dashboard' => "dashboard#index", as: :dashboard

  get '/students' => "students#index", as: :students
  get '/students/:id' => "students#show", as: :student
  get '/students/:id/edit' => "students#edit", as: :edit_student
  patch '/students/:id' => "students#update"


  get '/students/:id/applications' => "job_applications#index", as: :student_applications
  post '/students/:id/applications' => "job_applications#create"


  resources :companies do
    resources :job_posts
  end


  get '/job_search' => "search#job_search", as: :job_search
  get '/student_search' => "search#student_search", as: :student_search
  get '/company_search' => "search#company_search", as: :company_search




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
