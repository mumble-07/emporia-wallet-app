class History < ActiveRecord::Migration[6.0]
  def change
    create_table :histories do |t|
    t.integer :user_id
      t.integer :portfolio_id
      t.string :type
      t.string :market_symbol
      t.float :curr_stock_price
      t.float :amount

      t.timestamps
  end
end
end
