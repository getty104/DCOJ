class AddScoreToJoins < ActiveRecord::Migration[5.0]
  def change
    add_column :joins, :score, :integer, default: 0
  end
end
