Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        omniauth_callbacks: 'users/omniauth_callbacks'
      }
  devise_scope :user do
    get 'profile_edit', to: 'users/registrations#profile_edit', as: 'profile_edit'
    patch 'profile_update', to: 'users/registrations#profile_update', as: 'profile_update'
  end
  root 'pages#index'
  get 'follow/:id' => 'relationships#follow', as: 'follow'
  get 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'
  get  'search', to: 'microposts#search'
  resources :pages
  resources :microposts, only: [:new, :show, :create, :destroy] do
    resources :likes, only: [:create, :destroy]
    resources :postcomments, only: [:create]
  end
  resources :notifications, only: [:index, :destroy]


end
