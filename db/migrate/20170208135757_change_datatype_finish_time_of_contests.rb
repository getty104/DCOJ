class ChangeDatatypeFinishTimeOfContests < ActiveRecord::Migration[5.0]
  def change
  	  	change_column :contests, :finish_time, 'datetime USING CAST(finish_time AS datetime)'
  end
end
