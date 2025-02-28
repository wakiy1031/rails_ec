# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @products = Product.with_attached_img.order(created_at: :desc)
  end

  def show
    @product = Product.find(params[:id])
    @latest_product = Product.with_attached_img.order(created_at: :desc).limit(4).where.not(id: @product.id).distinct
  end
end
