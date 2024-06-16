# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :promotion_code, optional: true
  has_many :order_items, dependent: :destroy

  validates :first_name, presence: true, length: { maximum: 15 }
  validates :last_name, presence: true, length: { maximum: 15 }
  validates :user_name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :zip, presence: true, format: { with: /\A\d{3}(-\d{4})?\z/, message: 'は有効ではありません。' }
  validates :address1, presence: true
  validates :address2, presence: true, length: { maximum: 100 }
  validates :address3, presence: true, length: { maximum: 100 }
  validates :name_on_card, presence: true, length: { maximum: 50 }
  validates :card_number, presence: true, format: { with: /\A\d{16}\z/, message: 'は16桁であること。' }
  validates :expiration, presence: true, format: { with: %r{\A(0[1-9]|1[0-2])/\d{2}\z}, message: 'はMM/YY形式であること。' }
  validates :cvv, presence: true, format: { with: /\A\d{3,4}\z/, message: 'は3桁または4桁であること' }

  def total_price
    total = order_items.sum { |item| item.quantity * item.price }
    total -= promotion_code.discount if promotion_code.present?
    total
  end
end
