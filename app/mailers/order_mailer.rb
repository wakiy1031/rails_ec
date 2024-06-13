# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  default from: 'no-reply@example.com'

  def checkout_email(order)
    @order = order
    mail(to: @order.email, subject: '購入確認メール')
  end
end
