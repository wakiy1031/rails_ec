# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :current_cart
  before_action :set_cart
  before_action :set_cart_products

  private

  # セッションを使用して現在のカートを取得または作成する
  def current_cart
    @current_cart ||= Cart.find_or_create_by(id: session[:cart_id])
    session[:cart_id] = @current_cart.id
    @current_cart
  end

  def set_cart
    @cart = Cart.find(session[:cart_id])
  end

  def set_cart_products
    @cart_products = @current_cart.cart_products.includes(:product)
  end
end
