# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :user_name, null: false
      t.string :email, null: false
      t.string :zip, null: false
      t.string :address1, null: false
      t.string :address2, null: false
      t.string :address3, null: false
      t.string :name_on_card, null: false
      t.string :card_number, null: false
      t.string :expiration, null: false
      t.string :cvv

      t.timestamps
    end
  end
end
