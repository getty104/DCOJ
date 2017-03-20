class ChangeDefaultOfVolatilityToUsers < ActiveRecord::Migration[5.0]
  def change
  	change_column :users, :volatility, :decimal, default: 500
  end
end
