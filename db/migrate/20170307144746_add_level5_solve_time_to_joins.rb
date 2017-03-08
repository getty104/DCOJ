class AddLevel5SolveTimeToJoins < ActiveRecord::Migration[5.0]
  def change
    add_column :joins, :level5_solve_time, :integer
  end
end
