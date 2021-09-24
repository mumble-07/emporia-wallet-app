class UsersController < ApplicationController
  def index
    @portfolios = current_user.portfolios
    @wallet = current_user.wallet
  end

  def show; end
end
