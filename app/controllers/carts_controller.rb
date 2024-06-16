# frozen_string_literal: true

class CartsController < ApplicationController
  def index
    @order = Order.new
    @cart_products = current_cart.cart_products.includes(:product)
    @total_price = current_cart.total_price

    if session[:promotion_code]
      @promotion_code = PromotionCode.find_by(code: session[:promotion_code])
      @total_price -= @promotion_code.discount
    else
      @promotion_code = nil
    end
  end
end
