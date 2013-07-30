Hochuli::Application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks",
                                    registrations: 'registrations',
                                    sessions: 'sessions'
                                  }
  devise_scope :user do
    match '/registrations/update_avatar' => "registrations#update_avatar", :as => :update_avatar  
  end                  
  
  root :to => 'items#new'
  get '/popular'          => 'items#popular', as: :popular
  get '/user/:id'         => 'users#show', as: :user_show
  get '/collections/:id'  => 'users#collections', as: :user_collections
  get '/collection/:id/:collection_id' => 'users#collection', as: :user_collection
  get '/user'             => 'users#show'
  get '/follow/:id'       => 'users#follow', as: :follow
  get '/unfollow/:id'     => 'users#unfollow', as: :unfollow

  #search
  get "search"      => 'search#index', as: :search
  get "search/site" => 'search#site', as: :site
  get "frame/site"  => 'search#frame', as: :frame

  #item
  resources :items
  post 'item/:id/up'  => 'items#up', as: :like_item
  post 'item/:id/add/:collection_id' => 'items#add'

  #comments
  post 'item/:id/comment' => 'comments#create', as: :comment

end