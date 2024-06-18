# frozen_string_literal: true

class AddIsUsedToPromotionCodes < ActiveRecord::Migration[7.0]
  def change
    add_column :promotion_codes, :is_used, :boolean, default: false, null: false
  end
end
