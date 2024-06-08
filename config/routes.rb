# frozen_string_literal: true

Rails.application.routes.draw do
  root 'products#index'
  resources :products, only: %i[index show]
  resources :cart_products, only: %i[create destroy]
  resources :carts, only: %i[index]

  namespace :admin do
    resources :products, only: %i[index show new create edit update destroy]
  end
end
