class AddTypeToPortfolios < ActiveRecord::Migration[6.0]
  def change
    add_column :portfolios, :transaction_type, :string
  end
end
