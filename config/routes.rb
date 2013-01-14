Pickme::Application.routes.draw do
  root to: 'pages#intro'

  namespace :pages do
    get :intro
  end

  resources :users
  resources :game, only: [:index, :update]
end
