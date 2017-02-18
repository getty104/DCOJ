class ChangeDatatypeStartTimeOfContests < ActiveRecord::Migration[5.0]
  def up
  	remove_column :contests, :start_time
		add_column :contests, :start_time, :datetime
  end

  def down
			remove_column :contests, :start_time
		add_column :contests, :start_time, :time
	end
end
