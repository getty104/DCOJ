class AddContestEndToContests < ActiveRecord::Migration[5.0]
  def change
    add_column :contests, :contest_end, :boolean, default: false
  end
end
