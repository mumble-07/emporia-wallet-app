module PortfoliosHelper
  def current_price(curr_price, bool)
    usd_to_php = 50.06
    convert_price = curr_price * usd_to_php
    with_interest_total = bool ? convert_price + (convert_price * 0.05) : convert_price - (convert_price * 0.05)
    number_to_currency(with_interest_total, unit: 'PHP ')
  end

  def buy_stock; end
end
