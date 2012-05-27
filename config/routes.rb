Catalog::Application.routes.draw do
  root :to => 'pages#home'
  match '/browse',   :to => 'pages#browse'
  match '/browse/:id',   :to => 'pages#browse'
  match '/contact', :to => 'pages#contact'
  match '/about',   :to => 'pages#about'
  match '/search',   :to => 'pages#search'
  match '/auth',   :to => 'pages#auth'

  resources :items#, :only => [:new, :create, :show]
  #resources :rubrics
  resources :rubrics, :only => [:new, :create]
  
  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout

end
