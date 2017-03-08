class AddLevel4SolveTimeToJoins < ActiveRecord::Migration[5.0]
  def change
    add_column :joins, :level4_solve_time, :integer
  end
end
