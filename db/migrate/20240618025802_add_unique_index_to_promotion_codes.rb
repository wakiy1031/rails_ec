# frozen_string_literal: true

class AddUniqueIndexToPromotionCodes < ActiveRecord::Migration[7.0]
  def change
    add_index :promotion_codes, :code, unique: true
  end
end
