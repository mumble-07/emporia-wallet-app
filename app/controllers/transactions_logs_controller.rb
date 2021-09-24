class TransactionsLogsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :handle_error
  def index
    @transactions = current_user.transactions_logs
  end
end
