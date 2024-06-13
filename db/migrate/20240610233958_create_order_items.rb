# frozen_string_literal: true

class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.string :name
      t.integer :quantity
      t.integer :price

      t.timestamps
    end
  end
end
