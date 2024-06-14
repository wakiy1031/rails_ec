# frozen_string_literal: true

class RenameAddress1ColumnToOrders < ActiveRecord::Migration[7.0]
  def change
    rename_column :orders, :address_1, :address1
    rename_column :orders, :address_2, :address2
    rename_column :orders, :address_3, :address3
  end
end
