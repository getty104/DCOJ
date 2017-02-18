class ChangeDatatypeStartTimeOfContests < ActiveRecord::Migration[5.0]
  def change
  	change_column :contests, :start_time, 'datetime USING start_time::timestamp without time zone'
  end
end
