class CreateTransactionsLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions_logs do |t|

      t.timestamps
    end
  end
end
