module SeedsServices
  class CreateStockData < ApplicationService
    def call
      # delete market Data
      @logger.info 'Processing Market seed file'
      Market.destroy_all
      @logger.info 'Deleted all data from Market model'
      # initialize api client
      client = IEX::Api::Client.new(
        publishable_token: Rails.application.credentials.iex_global_api[:publishable_token],
        secret_token: Rails.application.credentials.iex_global_api[:secret_token],
        endpoint: 'https://sandbox.iexapis.com/v1'
      )
      @logger.info 'Fetching data from text file'

      # open text file for list of available markets in API
      file = File.open('app/api/stock_lists/market_symbol_bkp.txt')
      file_data = file.readlines.map(&:chomp)
      @logger.info 'Fetching data from API...'

      # Loop through each market to create data
      file_data.each do |data|
        begin
          Market.create(market_symbol: data, name: client.company(data).company_name, curr_price: client.price(data), logo_url: "https://storage.googleapis.com/iex/api/logos/#{data}.png")
        rescue StandardError
          nil
        end
        @logger.info "#{data} market data added."
      end
      @logger.info 'Fetching data from API completed'
    end
  end
end
