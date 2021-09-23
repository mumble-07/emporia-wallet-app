class TransactionsLogsController < ApplicationController
  def index
    @transactions = current_user.transactions_logs
  end
end
