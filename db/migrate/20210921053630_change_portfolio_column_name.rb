class ChangePortfolioColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :portfolios, :sample_stock_id, :market_id
  end
end
