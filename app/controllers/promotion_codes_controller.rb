# frozen_string_literal: true

class PromotionCodesController < ApplicationController
  before_action :check_promotion_code

  def create
    @promotion_code = PromotionCode.find_by(code: params[:code])

    if @promotion_code
      if @promotion_code.is_used
        flash[:alert] = 'この割引コードは使用済みです。'
      else
        @promotion_code.update(is_used: true)
        session[:promotion_code] = @promotion_code.code
        flash[:notice] = '割引コードを適用しました。'
      end
    else
      flash[:alert] = '不正な割引コードです。'
    end

    redirect_to carts_path
  end

  private

  def check_promotion_code
    return unless session[:promotion_code]

    flash[:alert] = '割引コードは、1回の買い物につき1回のみ使用可能です。'
    redirect_back(fallback_location: carts_path)
  end
end
