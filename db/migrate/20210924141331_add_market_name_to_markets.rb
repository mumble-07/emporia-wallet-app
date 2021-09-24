class AddMarketNameToMarkets < ActiveRecord::Migration[6.0]
  def change
    add_column :markets, :name, :string
  end
end
