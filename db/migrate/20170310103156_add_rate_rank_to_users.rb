class AddRateRankToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :rate_rank, :integer
  end
end
