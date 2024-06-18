# frozen_string_literal: true

class PromotionCode < ApplicationRecord
  has_many :orders, dependent: :destroy

  validates :code, presence: true, uniqueness: true
  validates :is_used, inclusion: { in: [true, false] }
end
