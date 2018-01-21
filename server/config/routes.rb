Rails.application.routes.draw do

  resources :linecomments
  resources :globalnotifications
  
  post '/rate' => 'rater#create', :as => 'rate'
  resources :supplementaries
  resources :slides
  devise_for :users, :controllers => {sessions: "users/sessions",  :registrations => "users/registrations" }


  #resources :courses
  # get 'sessions/new'

  root 'profiles#show'

  mount Resque::Server, :at => "/resque"

  # enrollemts
  resources :courses do
    member do
      get :subscribe, :unsubscribe, :stats
    end
  end


  resources :submissions, only: [:index, :new, :create, :destroy]



  # static
  get    'denied'       => 'static_pages#denied'
  get    'changelog'    => 'static_pages#changelog'
  get    'tos'          => 'static_pages#termsofuse'
  get    'about'        => 'static_pages#about'

  #get    'me'           => 'profiles#index'


  # get 'profile/:id'  => 'users#profile'
  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/demo'
  get 'static_pages/changelog'
  get 'static_pages/correct'
  get 'static_pages/debug'
  get 'static_pages/termsofuse'

  get 'static_pages/about'

  resources :exercise_sheets , path: "sheets" do
    member do
      get 'download'
    end
    resources :exercise_tasks, path: "tasks"
  end

  resources :slides do
    member do
      get 'download'
    end
  end

  resources :supplementaries do
    member do
      get 'download'
    end
  end


  resources :exercise_tasks, path: "tasks"
  resources :users  do
    resources :enrollments
    member do
      get 'become'
    end
  end


  resources :linecomments
  resources :statistics


  resources :profiles
  resources :group_enrollment_preferences
  resources :courses do
    resources :groups
    resources :exercise_sheets
    resources :group_enrollment_preferences  do
      collection do
        get 'download'
      end
    end
    resources :messages
    resources :exams do
      member do
        get 'grade'
        post 'update_grades'
      end
    end
  end
  resources :enrollments
  resources :gradings


  resources :submissions do
    member do
      get 'download'
    end
  end


  resources :groups do
    resources :sheet do
      resources :gradings do

      end
    end
  end
  #resources :submissions

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
