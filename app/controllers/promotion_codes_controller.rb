# frozen_string_literal: true

class PromotionCodesController < ApplicationController
  before_action :check_promotion_code

  def create
    @promotion_code = PromotionCode.find_by(code: params[:code])

    if @promotion_code && !promotion_code_used?(@promotion_code.code)
      # セッション内にused_promotion_codesが存在しない場合は空の配列
      session[:used_promotion_codes] ||= []
      # プロモーションコードをused_promotion_codesに追加
      session[:used_promotion_codes] << @promotion_code.code
      session[:promotion_code] = @promotion_code.code
      flash[:notice] = '割引コードを適用しました。'
    else
      if @promotion_code
        flash[:alert] = 'この割引コードは既に使用されています。'
      else
        flash[:alert] = '不正な割引コードです。'
      end
    end
    redirect_to carts_path
  end

  private

  def check_promotion_code
    return unless session[:promotion_code]

    flash[:alert] = '割引コードは、1回の買い物につき1回のみ使用可能です。'
    redirect_back(fallback_location: carts_path)
  end

  def promotion_code_used?(code)
    session[:used_promotion_codes]&.include?(code)
  end
end
