class ChangeDatatypeStartTimeOfContests < ActiveRecord::Migration[5.0]
  def change
  	change_column :contests, :start_time, 'datetime USING CAST(start_time AS datetime)'
  end
end
