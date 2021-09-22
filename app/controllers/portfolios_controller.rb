class PortfoliosController < ApplicationController
  before_action :authenticate_user!
  # before_action :portfolio
  def new
    @markets = Market.all
    @markets = Market.find(params[:market_id])
    @wallets = Wallet.all
    @portfolio = current_user.portfolios.build
    @portfolios = Portfolio.all
    @portfolios = Portfolio.find_by(id: params[:user_id])
    @portfolios = Portfolio.find_by(id: params[:market_id])
    @buy_value = @markets.curr_price * 50.06 + (@markets.curr_price*50.06*0.05)
    @sell_value = @markets.curr_price * 50.06 - (@markets.curr_price*50.06*0.05)
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
    params.require(:portfolio).permit(:user_id, :market_symbol, :hist_price, :amount, :market_id)
  end

  # def portfolio
  #   @portfolio = Portfolio.find(params[:user_id])
  # end

  # def user
  #   @user = User.find(params[:user_id])
  # end
end
