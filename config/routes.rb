Hochuli::Application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks",
                                    registrations: 'registrations'
                                  }

  #items
  root :to => 'items#new'
  get '/popular' => 'items#popular', as: :popular
  get '/user/:id' => 'users#show', as: :user_show

end
