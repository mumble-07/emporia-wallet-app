module UsersHelper
  def get_curr_stock_price(market_symbol)
    Market.find_by(market_symbol: market_symbol).curr_price
  end

  def get_profit_or_loss(market)
    # to get p/l, we have to first have the following
    # - stock price it was bought
    # - current stock price as of the moment
    # - then calculate the difference using the units and the prices (historical and current)
    current_stock_price = mkt_value_with_original(get_curr_stock_price(market.market_symbol)) # curr stock price will be the original price (-5% charge)
    profit_or_loss_gross_val = market.units * current_stock_price
    profit_or_loss_peso = market.amount - profit_or_loss_gross_val
    profit_or_loss_pct = ((market.amount - profit_or_loss_gross_val) / market.amount)

    { profit_or_loss_pct: profit_or_loss_pct, profit_or_loss_peso: profit_or_loss_peso, profit_or_loss_gross_val: profit_or_loss_gross_val } # return a hash
  end
end
