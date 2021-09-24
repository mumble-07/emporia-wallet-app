class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :handle_error
  def index
    @portfolios = current_user.portfolios
    @wallet = current_user.wallet
  end

  def show; end
end
