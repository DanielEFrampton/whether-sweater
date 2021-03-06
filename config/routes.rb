Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get 'forecast', to: 'forecast#show'
      get 'munchies', to: 'munchies#show'
      get 'backgrounds', to: 'backgrounds#show'
      post 'users', to: 'users#create'
      post 'sessions', to: 'sessions#create'
      post 'road_trip', to: 'road_trip#create'
    end
  end

  get '*path', to: 'welcome#index'
end
