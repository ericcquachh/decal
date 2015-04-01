Decal::Application.routes.draw do

  devise_for :users, :controllers =>{:omniauth_callbacks => "omniauth_callbacks", :registrations=>"registrations" }

  resources :courses

  match 'promote' => 'courses#promote'
  match 'demote' => 'courses#demote'

  root :to => 'courses#index'

end
