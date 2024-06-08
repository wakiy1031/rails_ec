# frozen_string_literal: true

class CartProductsController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    cart_product = current_cart.cart_products.find_or_initialize_by(product_id: params[:product_id])

    if cart_product.new_record?
      cart_product.quantity = params[:quantity].to_i
      message = "#{product.name} をカートに追加しました。"
    else
      cart_product.quantity += params[:quantity].to_i
      message = "#{product.name} の数量を更新しました。"
    end

    if cart_product.save
      flash[:notice] = message
    else
      flash[:alert] = "#{product.name} が登録できませんでした。"
    end

    redirect_to request.referer
  end

  def destroy
    cart_product = current_cart.cart_products.find(params[:id])
    product_name = cart_product.product.name

    if cart_product.destroy
      redirect_to request.referer, notice: "#{product_name} をカートから削除しました。"
    else
      redirect_to request.referer, alert: "#{product_name} をカートから削除できませんでした。"
    end
  end
end
