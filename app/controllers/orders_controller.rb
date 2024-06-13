# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :basic_auth
  def create
    @order = Order.new(order_params)

    if @order.save
      @current_cart.cart_products.each do |item|
        OrderItem.create(
          order: @order,
          product: item.product,
          quantity: item.quantity,
          price: item.product.price
        )
      end
      @total_price = @current_cart.total_price
      @current_cart.cart_products.destroy_all

      OrderMailer.checkout_email(@order).deliver_now

      flash[:notice] = '購入ありがとうございます'
      redirect_to root_path
    else
      flash[:alert] = '購入処理に失敗しました'
      render 'carts/index', status: :unprocessable_entity
    end
  end

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end

  def order_params
    params.require(:order).permit(
      :first_name,
      :last_name,
      :user_name,
      :email,
      :zip,
      :address1,
      :address2,
      :address3,
      :name_on_card,
      :card_number,
      :expiration,
      :cvv
    )
  end
end
