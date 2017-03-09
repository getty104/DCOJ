class AddRateAndVolatilityToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :rate, :integer, default: 1200
    add_column :users, :volatility, :decimal, default: 300
  end
end
