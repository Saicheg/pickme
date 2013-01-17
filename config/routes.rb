Pickme::Application.routes.draw do
  root to: 'pages#intro'

  resources :users
  resources :game, only: [:index, :update] do
    collection do
      post :pair
    end
  end

  namespace :pages do
    get :intro
  end

  resources :boosts, only: [:index, :create] do
    member do
      post :activate
    end
  end
end
