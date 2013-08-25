Hochuli::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks",
                                    registrations: 'registrations',
                                    sessions: 'sessions'
                                  }
  devise_scope :user do
    get '/registrations/update_avatar' => "registrations#update_avatar", :as => :update_avatar  
    get '/confirm/:confirmation_token', :to => "devise/confirmations#show", :as => "user_confirm", :only_path => false
  end                  
  
  root :to => 'items#new'
  get '/popular'          => 'items#popular', as: :popular
  get '/user/:id'         => 'users#show', as: :user_show
  get '/collections/:id'  => 'users#collections', as: :user_collections
  get 'mentions/:id'      => 'users#mentions', as: :mentions
  get '/collection/:id/:collection_id' => 'users#collection', as: :user_collection
  get '/user'             => 'users#show'
  get '/follow/:id'       => 'users#follow', as: :follow
  get '/unfollow/:id'     => 'users#unfollow', as: :unfollow
  get '/shops'            => 'users#shops',     as: :shops
  get '/people'            => 'users#people',     as: :people

  #search
  get "search"      => 'search#index', as: :search
  get "search/site" => 'search#site', as: :site
  get "frame/site"  => 'search#frame', as: :frame
  get "results"  => 'search#results'
  get "results/items/:query" => 'search#items', as: :search_items
  get "results/shops/:query" => 'search#shops', as: :search_shops
  get "results/collections/:query" => 'search#collections', as: :search_collections
  get "results/people/:query" => 'search#people', as: :search_people

  #item
  resources :items
  post '/items/new/:position' => 'items#new'
  post '/items/new/comments/:get_comments' => 'items#new'
  post '/items/popular/:position' => 'items#popular'
  post 'male/:sex/:position' => 'items#male'
  get 'male/:sex' => 'items#male', as: :items_by_sex
  get 'tag/:tag'  => 'items#tags', as: :tags
  post 'item/:id/up'  => 'items#up', as: :like_item
  post 'item/:id/add/:collection_id' => 'items#add'
  post 'item/:id/change_url' => 'items#change_url'

  #collections
  post 'collection/create' => 'collections#create'
  post 'collection/remove/:collection_id' => 'collections#remove'
  post 'item/remove/:item_id' => 'items#remove'
  #comments
  post 'item/:id/comment' => 'comments#create', as: :comment
  post 'comment/remove/:id' => 'comments#remove'
  #tracking
  get "followers/:user_id" => 'tracking#followers', as: :followers
  get "followed_by/:user_id" => 'tracking#followed_by', as: :followed_by
  get "followed_by_shop/:user_id" => 'tracking#followed_by_shop', as: :followed_by_shop
  post "tracking/unfollow/:id" => "tracking#unfollow"

  #tape
  get "tape" => "tape#index", as: :tape
  post "tape/:time" => "tape#by_time"

end
