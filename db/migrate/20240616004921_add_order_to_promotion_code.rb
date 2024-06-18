# frozen_string_literal: true

class AddOrderToPromotionCode < ActiveRecord::Migration[7.0]
  def change
    add_reference :promotion_codes, :order, foreign_key: true
  end
end
