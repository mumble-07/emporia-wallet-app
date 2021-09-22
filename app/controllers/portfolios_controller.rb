class PortfoliosController < ApplicationController
  before_action :authenticate_user!
  #before_action :portfolio
  def new
    @markets = Market.all
    @markets = Market.find(params[:market_id])
    @portfolio = Portfolio.new
    @portfolios = Portfolio.all
    @portfolios = Portfolio.find_by_id(params[:user_id])
    @portfolios = Portfolio.find_by_id(params[:market_id])
  end

  def create
    @portfolio = @markets.portfolios.build(portfolio_params)
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
