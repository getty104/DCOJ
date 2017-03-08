class AddAmountTimeToJoins < ActiveRecord::Migration[5.0]
  def change
    add_column :joins, :amount_time, :integer, default: 0
  end
end
