require 'rails_helper'

RSpec.describe Market, type: :model do
  context 'when doing API fetching' do
    it 'is not valid if market_symbol is not fetched ' do
      market = described_class.new(market_symbol: nil, curr_price: 100.50, logo_url: 'some_url_here')
      expect(market).not_to be_valid
    end

    it 'is not valid if curr_price is not fetched' do
      market = described_class.new(market_symbol: 'AA', curr_price: nil, logo_url: 'some_url_here')
      expect(market).not_to be_valid
    end

    it 'is not valid if logo_url is not fetched' do
      market = described_class.new(market_symbol: 'AA', curr_price: 100.50, logo_url: nil)
      expect(market).not_to be_valid
    end
  end
end
