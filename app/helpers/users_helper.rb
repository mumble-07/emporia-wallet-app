module UsersHelper
  def user_balance(bal)
    number_to_currency(bal, unit: 'PHP ')
  end

  def units_stock(invested, buy_value)
    invested ||= 0
    usd_to_php = 50.06
    convert_price = usd_to_php * buy_value
    with_interest_total = convert_price * 1.05
    num_stock = invested / with_interest_total
    number_with_precision(num_stock, precision: 5)
  end

  def invested_value(invested)
    number_to_currency(invested, unit: 'PHP ')
  end

  def percent_lg(curr_price, invested)
    # will finish sell first
  end

  def current_value(curr_price)
    usd_to_php = 50.06
    convert_price = curr_price * usd_to_php
    with_interest_total = convert_price * 1.05
    number_to_currency(with_interest_total, unit: 'PHP ')
  end

  def get_curr_stock_price(market_symbol)
    Market.find_by(market_symbol: market_symbol).curr_price
  end

  def get_val_invest_diff(invest, curr_price)
    # will finish sell first
  end
end
