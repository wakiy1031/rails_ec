# frozen_string_literal: true

Rails.application.routes.draw do
  root 'products#index'
  resources :products, only: %i[index show]
  resources :cart_products, only: %i[create destroy]
  resources :carts, only: %i[index]
  resources :orders, only: %i[create index show]

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  namespace :admin do
    resources :products, only: %i[index show new create edit update destroy]
  end
end
