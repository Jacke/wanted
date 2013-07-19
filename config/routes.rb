Hochuli::Application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks",
                                    registrations: 'registrations',
                                    sessions: 'sessions'
                                  }
  devise_scope :user do
    match '/registrations/update_avatar' => "registrations#update_avatar", :as => :update_avatar  
  end                  
  
  root :to => 'items#new'
  get '/popular' => 'items#popular', as: :popular
  get '/user/:id' => 'users#show', as: :user_show

  #search
  get "search/index" => 'search#index', as: :search
  get "search/site" => 'search#site', as: :site

end
