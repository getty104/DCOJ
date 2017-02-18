class ChangeDatatypeFinishTimeOfContests < ActiveRecord::Migration[5.0]
	def change
		change_column :contests, :finish_time, 'datetime USING finish_time::timestamp without time zone'
	end
end
