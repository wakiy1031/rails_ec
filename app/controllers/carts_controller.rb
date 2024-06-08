# frozen_string_literal: true

class CartsController < ApplicationController
  def index
    @cart_products = current_cart.cart_products.includes(:product)
    @total_price = current_cart.total_price
  end
end
