module TransactionsLogsHelper
  def transaction_logs_parser(transaction)
    case transaction.transaction_type
    when 'BUY'
      "Bought #{transaction.units.round(2)} units of #{transaction.market_symbol} stocks at Php #{transaction.hist_stock_price.round(2)} per stock for a total of Php #{transaction.amount.round(2)}. "
    when 'SELL'
      "Sold #{transaction.units.round(2)} units of #{transaction.market_symbol} stocks at Php #{transaction.hist_stock_price.round(2)} per stock for a total of Php #{transaction.amount.round(2)}. "
    end
  end
end
