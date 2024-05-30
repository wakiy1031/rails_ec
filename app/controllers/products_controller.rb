# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    @latest_product = Product.order(created_at: :desc).limit(4)
  end

  def create
    product = Product.create!(product_params)
    session[:product_id] = product.id
    redirect_to root_path
  end

  private

  def product_params
    params.require(:product).permit(:img)
  end
end
