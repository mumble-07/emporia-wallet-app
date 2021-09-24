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
    portfolio_transaction_logic(is_market_available)
  end

  private

  def portfolio_params
    params.require(:portfolio).permit(:user_id, :market_symbol, :hist_price, :units, :amount, :market_id, :transaction_type)
  end

  def convert_to_units(invested, stock_price)
    invested / stock_price
  end

  def portfolio_transaction_logic(is_market_available)
    @trader_wallet = current_user.wallet
    case params[:portfolio][:transaction_type]
    when 'BUY'
      portfolio_buy_logic(is_market_available)
    when 'SELL'
      portfolio_sell_logic(is_market_available)
    end
  end

  def portfolio_buy_logic(is_market_available)
    if is_market_available.nil?
      # if there is no market, create one
      @portfolio = current_user.portfolios.build(portfolio_params)
      @portfolio.units = @portfolio.amount / @portfolio.hist_price
      @trader_wallet.balance = current_user.wallet.balance - @portfolio.amount
      @portfolio.save if @trader_wallet.balance.positive?
      portfolio_buy_logic_update(@trader_wallet, @portfolio, @portfolio.units)
    else
      @portfolio = is_market_available
      amount = params[:portfolio][:amount].to_f
      stock_price = params[:portfolio][:hist_price].to_f
      units_to_be_added = amount / stock_price
      @portfolio.units = (@portfolio.units + units_to_be_added)
      @portfolio.amount = (@portfolio.amount + params[:portfolio][:amount].to_f)
      @trader_wallet.balance = current_user.wallet.balance - params[:portfolio][:amount].to_f
      @portfolio.save if @trader_wallet.balance.positive?
      portfolio_buy_logic_create(@trader_wallet, @portfolio, units_to_be_added)
    end
  end

  def portfolio_buy_logic_update(trader_wallet, portfolio, units_to_be_added)
    if trader_wallet.balance.positive? && portfolio.save
      trader_wallet.save
      # create transaction
      create_transaction_log_buy(units_to_be_added)
      redirect_to users_path, success: 'Successfully bought stocks'
    else
      redirect_back fallback_location: users_path, danger: 'Kindly double check all information before submitting. Also please check if balance is sufficient.'
    end
  end

  def portfolio_buy_logic_create(trader_wallet, portfolio, units_to_be_added)
    if trader_wallet.balance.positive? && portfolio.save
      trader_wallet.save
      # create transaction
      create_transaction_log_buy(units_to_be_added)
      redirect_to users_path, success: 'Successfully bought stocks'

      # id: integer, user_id: integer, portfolio_id: integer, transaction_type: string, market_symbol: string, hist_stock_price: float, amount: float, units: float, transaction_date: datetime, created_at: datetime, updated_at: datetime

    else
      redirect_back fallback_location: users_path, danger: 'Kindly double check all information before submitting. Also please check if balance is sufficient.'
    end
  end

  def portfolio_sell_logic(is_market_available)
    if is_market_available.nil? || is_market_available.units < params[:portfolio][:units].to_f
      # if there is no market, show error
      redirect_back fallback_location: users_path, danger: 'Please check if you have enough stock available for this market'
    else
      # if market is available do sell logic
      @portfolio = is_market_available
      @portfolio.units = (@portfolio.units - params[:portfolio][:units].to_f) # subtract stocks
      # balance will be subtracted. sell price is calculated as current units to be sold * current stock price (hist_price variable)
      @trader_wallet.balance = current_user.wallet.balance + params[:portfolio][:units].to_f * params[:portfolio][:hist_price].to_f
      @trader_wallet.save
      # destroy if 0 units left. Save if not
      @portfolio.units.zero? ? @portfolio.destroy : @portfolio.save
      # create transaction
      create_transaction_log_sell
      # redirect
      redirect_to users_path, success: 'Stock successfully sold!'
    end
  end

  def create_transaction_log_buy(units_to_be_added)
    TransactionsLog.create(user_id: current_user.id, transaction_type: params[:portfolio][:transaction_type], market_symbol: params[:portfolio][:market_symbol], hist_stock_price: params[:portfolio][:hist_price].to_f, amount: params[:portfolio][:amount].to_f, units: units_to_be_added, transaction_date: Date.current)
  end

  def create_transaction_log_sell
    TransactionsLog.create(user_id: current_user.id, transaction_type: params[:portfolio][:transaction_type], market_symbol: params[:portfolio][:market_symbol], hist_stock_price: params[:portfolio][:hist_price].to_f, amount: (params[:portfolio][:units].to_f * params[:portfolio][:hist_price].to_f), units: params[:portfolio][:units].to_f, transaction_date: Date.current)
  end
end
