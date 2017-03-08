class AddLevel2SolveTimeToJoins < ActiveRecord::Migration[5.0]
  def change
    add_column :joins, :level2_solve_time, :integer
  end
end
