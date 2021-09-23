class HistoriesController < ApplicationController
  def index
    # @histories = History.all
    @histories = History.where(user_id: current_user)
  end
end
