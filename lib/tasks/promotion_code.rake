# frozen_string_literal: true

namespace :promotion_code do
  desc 'プロモーションコードの生成'
  task generate: :environment do
    10.times do |i|
      PromotionCode.create(
        code: SecureRandom.alphanumeric(7),
        discount: (i + 1) * 100
      )
    end
  end
end
