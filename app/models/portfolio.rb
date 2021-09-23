class Portfolio < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :market_symbol, presence: true
  validates :hist_price, presence: true
end
