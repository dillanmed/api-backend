Rails.application.routes.draw do
namespace :api do
  namespace :v1 do
    post 'auth/login', to: 'auth#login'
    get 'users/me', to: 'users#me'
    patch 'users/me', to: 'users#update_me'
    put 'users/me', to: 'users#update_me'
    delete 'users/me', to: 'users#destroy_me'

    resources :users, only: [:index, :create]
  end
end


  
  get "up" => "rails/health#show", as: :rails_health_check


end
