Decal::Application.routes.draw do

    devise_for :users, :controllers =>{:omniauth_callbacks => "omniauth_callbacks", :registrations=>"registrations" }

    resources :courses do
        resources :sections
    end

    # paths for dashboard
    resources :dashboard
    resources :existing_courses
    
    delete '/dashboard', to: 'dashboard#delete', as: 'dashboard'
    # get '/dashboard/existing', to: 'dashboard#show', as: 'dashboard_existing'

    match 'promote' => 'courses#promote'
    match 'demote' => 'courses#demote'

    # match '/courses/:id/addsection' => 'courses#addsection', :as => :add_section, :via => :get
    # match '/courses/:id/updatesection' => 'courses#updatesection', :as => :update_section, :via => :post

    root :to => 'courses#index'

end
