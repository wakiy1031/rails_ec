# frozen_string_literal: true

class AddImgToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :img, :string
  end
end
