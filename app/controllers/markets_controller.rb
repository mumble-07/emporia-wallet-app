class MarketsController < ApplicationController
  def index
    @markets = Market.all
    @portfolios = Portfolio.all
    @user_id = params[:user_id]
    @portfolios = Portfolio.find_by(id: params[:user_id])

    # @portfolio = Market.portfolio.find_by(id: params[:user_id])
  end

  private

  def portfolio_params; end
end
