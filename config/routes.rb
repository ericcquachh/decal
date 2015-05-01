Decal::Application.routes.draw do

  devise_for :users, :controllers =>{:omniauth_callbacks => "omniauth_callbacks", :registrations=>"registrations" }

  resources :home, only: [:index]

  resources :courses, except: [:destroy] do
      resources :sections, except: [:show]
      resources :uploads, only: [:index, :new, :create, :destroy]
      # paths for adding facilitator to courses
      resources :facilitator, only: [:index, :create]
      delete '/facilitator', to: 'facilitator#delete', as: 'facilitator_delete'
  end
  # path for dashboard
  resources :dashboard, only: [:index]

  resources :admin, only: [:index, :create]
  match 'remove_facilitators' => 'admin#remove_facilitators'

  # get '/dashboard/existing', to: 'dashboard#show', as: 'dashboard_existing'
  match 'promote' => 'courses#promote'
  match 'demote' => 'courses#demote'
  match 'makeadmin' => 'courses#makeadmin'
  match 'removeadmin' => 'courses#removeadmin'
  match 'facilitator_request' => 'courses#facilitator_request'

  match 'add_semester' => 'admin#add_semester'
  match 'add_category' => 'admin#add_category'
  match 'remove_semester' => 'admin#remove_semester'
  match 'remove_category' => 'admin#remove_category'
  

  match 'favorites' => 'courses#favorites'
  match 'unfavorite' => 'courses#unfavorite'
  # match '/courses/:id/addsection' => 'courses#addsection', :as => :add_section, :via => :get
  # match '/courses/:id/updatesection' => 'courses#updatesection', :as => :update_section, :via => :post

  root :to => 'home#index'

end
