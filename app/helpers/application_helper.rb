module ApplicationHelper
  def append_admin_style_parent_container(curr_class)
    request.fullpath.start_with?('/admins/') && admin_signed_in? == false ? "#{curr_class} admin" : curr_class.to_s
  end

  def append_admin_style(curr_class)
    request.fullpath.start_with?('/admins/') ? "#{curr_class} admin" : curr_class.to_s
  end

  def format_to_peso(amount)
    number_to_currency(amount, unit: 'PHP ')
  end

  def mkt_value_with_interest(type, mkt_current_price)
    mkt_price_in_peso = mkt_current_price * 50.06
    mkt_price_in_peso_with_interest = mkt_price_in_peso * 0.05
    case type
    when 'buy'
      mkt_price_in_peso + mkt_price_in_peso_with_interest
    when 'sell'
      mkt_price_in_peso - mkt_price_in_peso_with_interest
    end
  end

  def mkt_value_with_original(mkt_current_price)
    mkt_current_price * 50.06
  end

  def get_logo_url(sym)
    Market.find_by(market_symbol: sym).logo_url
  end

  def get_market_name(sym)
    Market.find_by(market_symbol: sym).name
  end
end
