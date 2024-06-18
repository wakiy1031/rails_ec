# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :basic_auth
  before_action :set_cart_products
  before_action :set_promotion_code, only: %i[create]

  def create
    @order = Order.new(order_params)
    @order.promotion_code = @current_promotion_code if @current_promotion_code
    if @order.save
      create_order_items
      @total_price = @current_cart.total_price
      @current_cart.cart_products.destroy_all
      session.delete(:promotion_code)
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
    @total_price = calculate_total_price(@order)
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

  def create_order_items
    @current_cart.cart_products.each do |item|
      OrderItem.create(
        order: @order,
        product: item.product,
        quantity: item.quantity,
        price: item.product.price
      )
    end
  end

  def set_promotion_code
    @current_promotion_code = PromotionCode.find_by(code: session[:promotion_code]) if session[:promotion_code].present?
  end

  def calculate_total_price(order)
    total_price = order.order_items.sum { |item| item.price * item.quantity }
    if order.promotion_code.present?
      discount = order.promotion_code.discount
      total_price -= discount
    end
    total_price
  end
end
