class ChangeDatatypeStartTimeOfContests < ActiveRecord::Migration[5.0]
  def change
  	change_column :contests, :start_time, :datetime
  end
end
