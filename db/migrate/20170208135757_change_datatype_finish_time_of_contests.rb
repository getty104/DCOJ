class ChangeDatatypeFinishTimeOfContests < ActiveRecord::Migration[5.0]
	def up
		remove_column :contests, :finish_time
		add_column :contests, :finish_time, :datetime
	end

	def down
			remove_column :contests, :finish_time
		add_column :contests, :finish_time, :time
	end
end
