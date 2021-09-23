class PortfoliosController < ApplicationController
  before_action :authenticate_user!
  # before_action :portfolio
  def new
    @market = Market.find(params[:market_id])
    @wallet = current_user.wallet
    @portfolio = current_user.portfolios.build
    @buy_value = helpers.mkt_value_with_interest('buy', @market.curr_price)
    @sell_value = helpers.mkt_value_with_interest('sell', @market.curr_price)
    @current_stock = current_user.portfolios.find_by(market_symbol: @market.market_symbol)
  end

  def create
    is_market_available = current_user.portfolios.find_by(market_symbol: params[:portfolio][:market_symbol])
    @trader_wallet = current_user.wallet
    #check transaction type
    case params[:portfolio][:transaction_type]
      when "BUY"
        if is_market_available.nil?
          #if there is no market, create one
          @portfolio = current_user.portfolios.build(portfolio_params)
          @portfolio.units = @portfolio.amount / @portfolio.hist_price
          @trader_wallet.balance = current_user.wallet.balance - @portfolio.amount
          @portfolio.save if @trader_wallet.balance > 0
          if @trader_wallet.balance > 0 && @portfolio.save
            @trader_wallet.save
            redirect_to users_path, success: 'Successfully bought stocks'
          else
            redirect_back fallback_location: users_path, danger: 'Kindly double check all information before submitting. Also please check if balance is sufficient.'
          end

        else
          @portfolio = is_market_available
          units_to_be_added = params[:portfolio][:amount].to_f / params[:portfolio][:hist_price].to_f
          @portfolio.units = (@portfolio.units + units_to_be_added)
          @portfolio.amount = (@portfolio.amount + params[:portfolio][:amount].to_f)
          @trader_wallet.balance = current_user.wallet.balance - params[:portfolio][:amount].to_f
          @portfolio.save if @trader_wallet.balance > 0
          if @trader_wallet.balance > 0 && @portfolio.save
            @trader_wallet.save
            redirect_to users_path, success: 'Successfully bought stocks'
          else
            redirect_back fallback_location: users_path, danger: 'Kindly double check all information before submitting. Also please check if balance is sufficient.'
          end

        end
      when "SELL"
    end

  end

  private

  def portfolio_params
    params.require(:portfolio).permit(:user_id, :market_symbol, :hist_price, :units, :amount, :market_id, :transaction_type)
  end

  def convert_to_units(invested, stock_price)
    invested / stock_price
  end
end
