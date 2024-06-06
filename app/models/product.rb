# frozen_string_literal: true

class Product < ApplicationRecord
  has_one_attached :img
  validates :name, presence: true, length: { maximum: 15 }
  validates :description, presence: true, length: { maximum: 300 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :stock, presence: true, numericality: { only_integer: true }
end
