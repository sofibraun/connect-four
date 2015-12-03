Rails.application.routes.draw do
  
  resources :games, only: [:index, :show] do
    member do
      get  'refresh'
      post 'play', format: :json
    end
    collection do
      post 'reset'
    end
  end

  root 'games#index'

end
