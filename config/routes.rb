Rails.application.routes.draw do
 
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
   resources :trips
   resources :users
   put 'users/:id/role', to: 'users#update_role'
   get 'admin/get_all_trips', to: 'trips#get_all_trips'
   get 'print_monthly_trips/:month', to: 'trips#print_monthly_trips'
  end
 
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  
end
