class AddLevel3SolveTimeToJoins < ActiveRecord::Migration[5.0]
  def change
    add_column :joins, :level3_solve_time, :integer
  end
end
