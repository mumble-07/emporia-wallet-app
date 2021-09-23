class PortfoliosController < ApplicationController
  before_action :authenticate_user!
  # before_action :portfolio
  def new
    @markets = Market.find(params[:market_id])
    @wallet = current_user.wallet
    @portfolio = current_user.portfolios.build
    @buy_value = mkt_value_with_interest("buy", @markets.curr_price)
    @sell_value = mkt_value_with_interest("sell", @markets.curr_price)
  end

  def create
    @portfolio = current_user.portfolios.build(portfolio_params)
    if @portfolio.save
      redirect_to users_path
    else
      render :new
    end
  end

  private

  def portfolio_params
    params.require(:portfolio).permit(:user_id, :market_symbol, :hist_price, :amount, :market_id, :transaction_type)
  end

  def mkt_value_with_interest(type, mkt_current_price)
    mkt_price_in_peso = mkt_current_price * 50.06
    mkt_price_in_peso_with_interest = mkt_current_price * 50.06 * 0.05
    case type
    when "buy"
      mkt_price_in_peso + mkt_price_in_peso_with_interest
    when "sell"
      mkt_price_in_peso - mkt_price_in_peso_with_interest
    end
  end

end
