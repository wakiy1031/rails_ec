# frozen_string_literal: true

class AddProductIdToOrderItems < ActiveRecord::Migration[7.0]
  def change
    add_belongs_to :order_items, :product, null: true
  end
end
