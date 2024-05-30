# frozen_string_literal: true

class Product < ApplicationRecord
  has_one_attached :img do |attachable|
    attachable.variant :thumb, resize_to_limit: [450, 300]
  end
end
