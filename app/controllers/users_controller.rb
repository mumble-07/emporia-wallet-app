class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :handle_error
  def index
    @portfolios = current_user.portfolios.order('market_symbol ASC')
    @wallet = current_user.wallet
  end

  def show; end
end
