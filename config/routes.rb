Audicle::Application.routes.draw do
  get "landings/index"

  get "/starred" => "users#starred", as:"starred"

  devise_for :users, controllers: {registrations: "users/registrations", sessions: "users/sessions", passwords: "users/passwords"}, skip: [:sessions, :registrations]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  authenticated :user do
    root to: "dashboards#index", as: :authenticated_root
  end
  unauthenticated do
    devise_scope :user do
      root to: "landings#index", as: :unauthenticated_root
    end
  end

  resources :articles

  resources :recordings do
    member do 
      put "like", to: "recordings#upvote"
      put "dislike", to: "recordings#downvote"
      post :vote_up
    end
  end

  post "recordings/upload", :as => 'upload'
  # get "recordings/delete", :as => 'delete'
  post 'audioupload/extupload' => "audioupload#extupload"
  resources :topics do
      resources :follows,  controller: "follows_topics", :only => [:create, :destroy]
      resources :follows,  controller: "follows_topics", :only => [:create, :destroy]
    end
  resources :providers do
      resources :follows,  controller: "follows_providers", :only => [:create, :destroy]
      resources :follows,  controller: "follows_providers", :only => [:create, :destroy]
  end
  # resources :audios
  resources :users do
    resources :follows, :only => [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]

  devise_scope :user do
    get    "login"   => "devise/sessions#new",         as: :new_user_session
    post   "login"   => "devise/sessions#create",      as: :user_session
    delete "signout" => "devise/sessions#destroy",     as: :destroy_user_session

    get    "signup"  => "devise/registrations#new",    as: :new_user_registration
    post   "signup"  => "devise/registrations#create", as: :user_registration
    put    "signup"  => "devise/registrations#update", as: :update_user_registration
    get    "account" => "devise/registrations#edit",   as: :edit_user_registration
  end
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