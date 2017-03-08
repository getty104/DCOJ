class AddLevel1SolveTimeToJoins < ActiveRecord::Migration[5.0]
  def change
    add_column :joins, :level1_solve_time, :integer
  end
end
