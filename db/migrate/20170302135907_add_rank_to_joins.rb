class AddRankToJoins < ActiveRecord::Migration[5.0]
  def change
    add_column :joins, :rank, :integer
  end
end
