# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CartProducts', type: :request do
  describe 'GET /create' do
    it 'returns http success' do
      get '/cart_products/create'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /destroy' do
    it 'returns http success' do
      get '/cart_products/destroy'
      expect(response).to have_http_status(:success)
    end
  end
end
