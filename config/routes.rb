Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  scope module: :v1, constraints: ApiVersion.new('v1', true)do
    resources :todos do
      resources :items
    end
  end
  
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  # Defines the root path route ("/")
  # root "articles#index"
end
