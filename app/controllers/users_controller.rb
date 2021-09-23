class UsersController < ApplicationController
  def index
    @users = User.all
    @markets = Market.all
    @portfolios = current_user.portfolios
    @wallets = Wallet.all
  end
end
