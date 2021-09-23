class CreateTransactionsLog < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions_logs do |t|
      t.integer :user_id
      t.integer :portfolio_id
      t.string :transaction_type
      t.string :market_symbol
      t.float :hist_stock_price
      t.float :amount
      t.float :units
      t.datetime :transaction_date

      t.timestamps
    end
  end
end
