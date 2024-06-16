# frozen_string_literal: true

class PromotionCode < ApplicationRecord
  has_many :orders, dependent: :destroy
end
