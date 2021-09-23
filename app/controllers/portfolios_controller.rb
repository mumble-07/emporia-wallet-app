class PortfoliosController < ApplicationController
  before_action :authenticate_user!
  # before_action :portfolio
  def new
    @market = Market.find(params[:market_id])
    @wallet = current_user.wallet
    @portfolio = current_user.portfolios.build
    @buy_value = mkt_value_with_interest("buy", @market.curr_price)
    @sell_value = mkt_value_with_interest("sell", @market.curr_price)
  end

  def create
    @portfolio = current_user.portfolios.build(portfolio_params)
    @portfolio.units = @portfolio.amount/@portfolio.hist_price
    if @portfolio.save
      redirect_to users_path
    else
      render :new
    end
  end

  private

  def portfolio_params
    params.require(:portfolio).permit(:user_id, :market_symbol, :hist_price, :units, :amount, :market_id, :transaction_type)
  end

  def convert_to_units(invested, stock_price)
    invested/stock_price
  end
  
end
