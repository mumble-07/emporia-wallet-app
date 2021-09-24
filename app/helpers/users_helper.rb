module UsersHelper
  def get_curr_stock_price(market_symbol)
    Market.find_by(market_symbol: market_symbol).curr_price
  end

  def get_profit_or_loss(market)
    # to get p/l, we have to first have the following
    # - stock price it was bought
    # - current stock price as of the moment
    # - then calculate the difference using the units and the prices (historical and current)
    # since we are calcuilating already the revenue, we will calculate it using the price of the application when selling - which is -5% of the original
    current_stock_price = mkt_value_with_interest('sell', get_curr_stock_price(market.market_symbol))
    profit_or_loss_gross_val = market.units * current_stock_price
    profit_or_loss_peso = profit_or_loss_gross_val - market.amount
    profit_or_loss_pct = ((profit_or_loss_gross_val - market.amount) / market.amount)

    { profit_or_loss_pct: profit_or_loss_pct, profit_or_loss_peso: profit_or_loss_peso, profit_or_loss_gross_val: profit_or_loss_gross_val } # return a hash
  end

  def get_total_profit_loss(portfolios)
    total_profit = 0

    portfolios.each do |portfolio|
      # since we are calcuilating already the revenue, we will calculate it using the price of the application when selling - which is -5% of the original
      current_stock_price = mkt_value_with_interest('sell', get_curr_stock_price(portfolio.market_symbol))
      total_profit += portfolio.units * current_stock_price
    end
    total_profit.round(3)
  end
end
