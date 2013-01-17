Pickme::Application.routes.draw do
  root to: 'pages#intro'

  resources :users
  resources :game, only: [:index] do
    collection do
      post :pair
    end
  end

  resources :picks, only: [:create]

  namespace :pages do
    get :intro
  end

  resources :boosts, only: [:index, :create] do
    member do
      post :activate
    end
  end
end
