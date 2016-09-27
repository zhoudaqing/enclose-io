Rails.application.routes.draw do
  root 'projects#index'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth' }

  resources :projects do
    resources :packages
  end

  resources :helps
end
