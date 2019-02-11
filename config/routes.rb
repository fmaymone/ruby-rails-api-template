Rails.application.routes.draw do
 resources :trips
 post 'auth/login', to: 'authentication#authenticate'
 post 'signup', to: 'users#create'
end
