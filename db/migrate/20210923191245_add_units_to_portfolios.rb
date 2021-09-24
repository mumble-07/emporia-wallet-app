class AddUnitsToPortfolios < ActiveRecord::Migration[6.0]
  def change
    add_column :portfolios, :units, :float
  end
end
