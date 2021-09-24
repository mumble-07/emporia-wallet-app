class MarketsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :handle_error
  def index
    @markets = Market.all.order('market_symbol ASC')
  end

  private

  def portfolio_params; end
end
