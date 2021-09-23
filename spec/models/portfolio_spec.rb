require 'rails_helper'

RSpec.describe Portfolio, type: :model do
  context 'when user buy or sell stocks' do
    it 'is not allowed without user_id' do
      portfolio = described_class.new(user_id: nil, market_symbol: 'AA', hist_price: 99.99, amount: 100.50)
      expect(portfolio).not_to be_valid
    end

    it 'is not allowed without market symbol' do
      portfolio = described_class.new(user_id: 1, market_symbol: nil, hist_price: 99.99, amount: 100.50)
      expect(portfolio).not_to be_valid
    end

    it 'is not allowed without sotck price (hist_price)' do
      portfolio = described_class.new(user_id: 1, market_symbol: 'AA', hist_price: nil, amount: 100.50)
      expect(portfolio).not_to be_valid
    end
  end
end
