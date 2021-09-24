module JobsServices
  class UpdateStockData < ApplicationService
    def call
      @logger.info 'Processing Market seed file'
      # initialize api client
      client = IEX::Api::Client.new(
        publishable_token: Rails.application.credentials.iex_global_api[:publishable_token],
        secret_token: Rails.application.credentials.iex_global_api[:secret_token],
        endpoint: 'https://sandbox.iexapis.com/v1'
      )
      @logger.info 'Fetching data from text file'

      # open text file for list of available markets in API
      file = File.open('app/api/stock_lists/market_symbol_100.txt')
      file_data = file.readlines.map(&:chomp)
      @logger.info 'Fetching data from API...'

      # Loop through each market to create data
      file_data.each do |data|
        begin
          @logger.info "Finding #{data} in DB."
          market = Market.find_by(market_symbol: data)
          var_num = rand(-10...10) # random number between -10 to 10 to test calculations
          @logger.info "Updating #{data} current price #{market.curr_price} to #{client.price(data) + var_num}. Variable added #{var_num} in DB."
          market.curr_price = client.price(data) + var_num
          market.save
        rescue StandardError
          nil
        end
        @logger.info "#{data} market data updated."
      end
      @logger.info 'Fetching data from API completed'
    end
  end
end
